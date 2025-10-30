#!/usr/bin/env bash

# Roll back an unsuccessful Maven release.
#
# What this script does:
# - Runs: mvn release:rollback (restores pom.xml from backups, removes release metadata)
# - Optionally deletes the Git tag created by the failed release (locally and/or remotely)
#
# Usage:
#   ./rollback.sh [--delete-tag] [--delete-remote-tag]
#
# Notes:
# - The tag name is read from release.properties (key: scm.tag).
# - If release.properties is missing or does not contain scm.tag, tag deletion is skipped.
# - This script is safe to run multiple times; missing artifacts are ignored gracefully.

set -euo pipefail

log() { printf "%s - %s\n" "$(date +%Y-%m-%dT%H:%M:%S)" "$*"; }
warn() { log "WARN: $*"; }
err()  { log "ERROR: $*"; }

DELETE_TAG=false
DELETE_REMOTE_TAG=false

for arg in "$@"; do
  case "$arg" in
    --delete-tag)
      DELETE_TAG=true
      ;;
    --delete-remote-tag)
      DELETE_TAG=true
      DELETE_REMOTE_TAG=true
      ;;
    -h|--help)
      sed -n '1,30p' "$0"
      exit 0
      ;;
    *)
      err "Unknown argument: $arg"
      exit 2
      ;;
  esac
done

# Step 1: Roll back the Maven release state
log "Running: mvn release:rollback ..."
mvn -B release:rollback || {
  # maven-release-plugin returns non-zero if there is nothing to roll back; treat as warning
  warn "mvn release:rollback returned non-zero; it may already be rolled back. Continuing."
}

# Step 2: Optionally delete the Git tag
if [[ "$DELETE_TAG" == true ]]; then
  TAG_NAME=""
  if [[ -f release.properties ]]; then
    TAG_NAME=$(grep -E '^scm.tag=' release.properties | head -n1 | cut -d'=' -f2- | tr -d '\r' || true)
  fi

  if [[ -z "$TAG_NAME" ]]; then
    warn "Could not determine tag name from release.properties (scm.tag). Skipping tag deletion."
  else
    if git rev-parse -q --verify "refs/tags/$TAG_NAME" >/dev/null 2>&1; then
      log "Deleting local tag: $TAG_NAME"
      git tag -d "$TAG_NAME" || warn "Failed to delete local tag $TAG_NAME (may not exist)."
    else
      warn "Local tag $TAG_NAME not found; skipping local deletion."
    fi

    if [[ "$DELETE_REMOTE_TAG" == true ]]; then
      # Determine default remote (prefer 'origin')
      REMOTE=origin
      if ! git remote | grep -qx "$REMOTE"; then
        # Fallback to the first configured remote if origin doesn't exist
        REMOTE=$(git remote | head -n1 || true)
      fi

      if [[ -n "$REMOTE" ]]; then
        log "Deleting remote tag: $TAG_NAME on remote: $REMOTE"
        # Push a delete ref for the tag; ignore failure to keep script idempotent
        git push "$REMOTE" ":refs/tags/$TAG_NAME" || warn "Failed to delete remote tag $TAG_NAME on $REMOTE (may not exist)."
      else
        warn "No Git remote configured; cannot delete remote tag."
      fi
    fi
  fi
fi

log "Rollback process completed."