# Use lightweight Alpine Linux as the base image
FROM alpine:latest

# Install required dependencies (curl, jq, bash)
RUN apk add --no-cache curl jq bash

# Set the working directory
WORKDIR /app

# Copy the migration script into the container
COPY gitea2forgejo.sh /app/

# Make sure the script is executable
RUN chmod +x /app/gitea2forgejo.sh

# Define environment variables
ENV GITEA_HTTP=""
ENV GITEA_DOMAIN=""
ENV GITEA_TOKEN=""
ENV GITEA_USERNAME=""

ENV FORGEJO_HTTP=""
ENV FORGEJO_DOMAIN=""
ENV FORGEJO_TOKEN=""
ENV FORGEJO_USERNAME=""

# Run the script when the container starts
CMD ["/bin/bash", "/app/gitea2forgejo.sh"]
