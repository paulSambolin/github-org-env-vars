#!/bin/bash

# Get env from argument
ENV=$1
# echo "env $ENV"

# Get all repos in Github Organization
REPOS=$(gh repo list $GITHUB_REPOSITORY_OWNER -L 1000 | cut -f 1)
# echo "repos $REPOS"

# Read environment file
VARIABLES=$(yq -r '.variables[]' $ENV.yml)
# echo "variables $VARIABLES"

# For each variable
for variable in $VARIABLES; do

  # Split the string
  ORG_VAR_NAME=$(echo $variable | cut -d ":" -f 1)
  REPO_ENV_VAR_NAME=$(echo $variable | cut -d ":" -f 2)
#   echo "split string $ORG_VAR_NAME:$REPO_ENV_VAR_NAME"
  
  # Get value of Github Action Organization Variable
  VALUE=${!ORG_VAR_NAME}
#   echo "value $VALUE"

  # For each Repo
  for repo in $REPOS; do

    # TODO: create env if it does not exist

    # Set Value of Repo Action Environment Variable
    # gh variable set -e $ENV -R $repo $REPO_ENV_VAR_NAME --body "$VALUE" || true
    echo "dryrun: gh variable set -e $ENV -R $repo $REPO_ENV_VAR_NAME --body \"$VALUE\" || true"
  done
done
