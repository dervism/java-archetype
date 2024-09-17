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

# Step 1: Prepare for the release
log "Preparing the release..."

# Get current version
CURRENT_VERSION=$(get_current_version)
log "Current project version: ${CURRENT_VERSION}"

# Prepare the release (this increments the version, tags the code, and prepares the release)
log "Running mvn release:prepare..."
mvn release:clean release:prepare

# Step 2: Perform the release
log "Performing the release..."
mvn release:perform

# Step 3: Post release activities (Optional):
# Note: Maven release plugin by default will update the version to the next development version

# Display current version after release
NEW_VERSION=$(get_current_version)
log "New project version: ${NEW_VERSION}"

log "Release process completed successfully."