#!/bin/bash

# Get env from argument
ENV=$1
# echo "env $ENV"

# Get all repos in Github Organization
REPOS=$(gh repo list $GITHUB_REPOSITORY_OWNER -L 1000 | cut -f 1)
# echo "repos $REPOS"

# For each Repo
for repo in $REPOS; do

  # List Repo Action Environment Variables
  gh variable list -e $ENV -R $repo || true
  # echo "dryrun: gh variable list -e $ENV -R $repo || true"
done
