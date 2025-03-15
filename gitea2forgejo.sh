#!/bin/bash

# Check if required environment variables are set
if [[ -z "$GITEA_DOMAIN" || -z "$GITEA_TOKEN" || -z "$GITEA_USERNAME" || -z "$GITEA_HTTP" || -z "$FORGEJO_DOMAIN" || -z "$FORGEJO_TOKEN" || -z "$FORGEJO_USERNAME" || -z "$FORGEJO_HTTP" ]]; then
    echo "Error: One or more required environment variables are missing!"
    exit 1
fi

echo "Starting migration from Gitea ($GITEA_DOMAIN) to Forgejo ($FORGEJO_DOMAIN)..."

# Get all repositories from Gitea user
GET_REPOS=$(curl -s -H "Authorization: token $GITEA_TOKEN" -H "Accept: application/json" \
    "$GITEA_HTTP://$GITEA_DOMAIN/api/v1/user/repos?per_page=200" | jq -r '.[].clone_url')

# Loop through repositories and migrate them to Forgejo
for URL in $GET_REPOS; do
    REPO_NAME=$(basename "$URL" .git)

    echo "Found repository: $REPO_NAME, migrating to Forgejo..."

    curl -X POST "$FORGEJO_HTTP://$FORGEJO_DOMAIN/api/v1/repos/migrate" \
        -H "Authorization: token $FORGEJO_TOKEN" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -d "{
            \"clone_addr\": \"$URL\",
            \"mirror\": false,
            \"private\": true,
            \"repo_name\": \"$REPO_NAME\",
            \"repo_owner\": \"$FORGEJO_USERNAME\",
            \"service\": \"git\",
            \"wiki\": false
        }"

    echo "Migration completed for $REPO_NAME."
done
