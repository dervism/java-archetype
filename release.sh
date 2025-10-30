#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to log messages
log() {
  echo "$(date +%Y-%m-%dT%H:%M:%S) - $1"
}

# Function to get the current project version from pom.xml
get_current_version() {
  mvn org.apache.maven.plugins:maven-help-plugin:3.2.0:evaluate -Dexpression=project.version -q -DforceStdout
}

# Parse arguments
DRY_RUN=false
for arg in "$@"; do
  case "$arg" in
    --dry-run|-n)
      DRY_RUN=true
      ;;
    -h|--help)
      echo "Usage: $0 [--dry-run|-n]"
      echo "  --dry-run, -n  Run Maven release prepare in dry-run mode (no tags/commits/push)."
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      echo "Try --help for usage." >&2
      exit 2
      ;;
  esac
done

# Step 1: Prepare for the release
if [ "$DRY_RUN" = true ]; then
  log "Dry run mode enabled. No tags, commits, or pushes will be created."
else
  log "Preparing the release..."
fi

# Get current version
CURRENT_VERSION=$(get_current_version)
log "Current project version: ${CURRENT_VERSION}"

# Prepare the release (this increments the version, tags the code, and prepares the release)
if [ "$DRY_RUN" = true ]; then
  log "Running mvn release:clean release:prepare in dry-run mode..."
  mvn -B release:clean release:prepare -DdryRun=true
  log "Dry run completed. You can now run $0 without --dry-run to perform the actual release."
  exit 0
else
  log "Running mvn release:prepare..."
  mvn -B release:clean release:prepare
fi

# Step 2: Perform the release
log "Performing the release..."
mvn -B release:perform

# Step 3: Post release activities (Optional):
# Note: Maven release plugin by default will update the version to the next development version

# Display current version after release
NEW_VERSION=$(get_current_version)
log "New project version: ${NEW_VERSION}"

log "Release process completed successfully."