# docker_gitea2forgejo
Import all repositories from a Gitea user to a Forgejo user 


```
docker run -it --rm \
    --name gitea2forgejo \
    -e GITEA_HTTP="https" \
    -e GITEA_DOMAIN="" \
    -e GITEA_TOKEN="" \
    -e GITEA_USERNAME="" \
    -e FORGEJO_HTTP="http" \
    -e FORGEJO_DOMAIN="" \
    -e FORGEJO_TOKEN="" \
    -e FORGEJO_USERNAME="" \
    ghcr.io/sthopeless/gitea2forgejo:latest
```
