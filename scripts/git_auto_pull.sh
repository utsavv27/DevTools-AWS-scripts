#!/bin/bash

# Define an array of repository paths
REPOS=(
"/home/utsav/Documents/workspace/gitlab_office/Nourishubs_all/github/Nourishubs-FE"
"/home/utsav/Documents/workspace/gitlab_office/Nourishubs_all/github/Nourishubs-BE"
"/home/utsav/Documents/workspace/gitlab_office/Nourishubs_all/github/nourishubs-mobile"
)
# Loop through each repo and pull updates for all branches
for REPO in "${REPOS[@]}"; do
    if [ -d "$REPO/.git" ]; then
        echo "Processing repository: $REPO"
        cd "$REPO" || { echo "Failed to access $REPO"; continue; }

        # Fetch all branches
        git fetch --all

        # Get all local branches
        BRANCHES=$(git branch --format="%(refname:short)")

        # Loop through each branch and pull the latest changes
        for BRANCH in $BRANCHES; do
            echo "Switching to branch: $BRANCH"
            git checkout "$BRANCH" || { echo "Failed to switch to $BRANCH"; continue; }
            git pull origin "$BRANCH"
        done
    else
        echo "Skipping $REPO - Not a valid Git repository"
    fi
done

echo "All repositories and branches updated!"

