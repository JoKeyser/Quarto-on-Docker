# Deploy configuration example

This Docker image is intended for use in GitLab CI pipelines.
How you configure the deployment of your Quarto documents depends on your specific use case and target environment.

As an example, the following shows how to deploy documents to a web server via `rsync` over SSH.
For alternative deployment methods, please refer to <https://quarto.org/docs/publishing/>.

## Configuration of GitLab CI

To deploy using `rsync` over SSH, add a deploy job to your `.gitlab-ci.yml` file like this:

```yaml
deploy_quarto_docs:
  stage: deploy
  script:
    - rsync -avz --delete --rsh="ssh -o StrictHostKeyChecking=no -i $SSH_PRIVATE_KEY_PATH" ./_site/ $DEPLOY_USER@$DEPLOY_HOST:$DEPLOY_PATH
  only:
    - main  # Adjust branch name as needed
    dependencies:
      - build_quarto_docs # Ensure this job runs after the build job
    variables:
        SSH_PRIVATE_KEY_PATH: "/tmp/deploy_key"
    before_script:
      - echo "$SSH_PRIVATE_KEY" > $SSH_PRIVATE_KEY_PATH
      - chmod 600 $SSH_PRIVATE_KEY_PATH
```

## Configuration on the deploy server

On the target server, make sure to add the corresponding public SSH key to the `~/.ssh/authorized_keys` file of the deploy user.
For enhanced security, you can restrict the key to only allow `rsync` commands by using a command restriction.

> [!TIP]
> If your deploy user has `bash` as their shell, you may want to change that to a simpler shell, e.g. `dash`, see ["Bash Security Issue" section in the `rrsync` documentation](https://download.samba.org/pub/rsync/rrsync.1#BASH_SECURITY_ISSUE).

For example, to restrict access to `rrsync` (restricted `rsync`), add a line like this to your deploy user's `~/.ssh/authorized_keys` file, e.g. using `/var/www` as the only valid target directory for deployment:

```txt
command="rrsync -wo /var/www" ssh-ed25519 AAAAC3NzaC1...
```

Option `-wo` specifies write-only access for `rsync` from the client side; without that option, the client could also read files from the server, which is unnecessary and potentially insecure.
