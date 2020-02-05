#!/bin/sh

# Ensure CIRCLE_TOKEN is set. Obtain an api token by following these docs:
#   https://circleci.com/docs/api/#authentication

curl --location --request GET "https://circleci.com/api/v1.1/project/$VCS_NAME/$USERNAME/$PROJECT_NAME/$BUILD_NUMBER/artifacts?circle-token=$CIRCLE_TOKEN&branch=$BRANCH" | grep -o 'https://[^\"]*' | sed -e "s/\$/?circle-token=$CIRCLE_TOKEN/" | wget -P tmp/ -v -i -
