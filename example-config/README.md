# Configuration example for RRZ GitLab

This Docker image is intended for use in GitLab CI/CD pipelines.
You can adapt it to your own Quarto documents and your specific use case and target environment.

The example below would deploy the rendered Quarto documents to a web server via `rsync` over SSH.
The example is tailored for deployment to a web server at the University of Hamburg's RRZ, but should be easy to adapt to other environments.
For more deployment methods, please refer to <https://quarto.org/docs/publishing/>.

## Configuration of GitLab CI

In your target project's `.gitlab-ci.yml` file, you can specify the stages and jobs for building and deploying your Quarto documents.
See the example configuration in [.gitlab-ci.yml](.gitlab-ci.yml) for details.

## Configuration on the deploy server

On the target server, make sure to add the corresponding public SSH key to the `~/.ssh/authorized_keys` file of the deploy user.
For enhanced security, you can restrict the SSH key to only allow only specific commands, e.g. using `rrsync` (restricted `rsync`), which is a wrapper around `rsync` that restricts the allowed commands and paths for the SSH key, see below.

> [!TIP]
> If your deploy user has `bash` as their shell, you may want to change that to a simpler shell, e.g. `dash`, see ["Bash Security Issue" section in the `rrsync` documentation](https://download.samba.org/pub/rsync/rrsync.1#BASH_SECURITY_ISSUE).

To restrict the SSH key's access to only `rrsync` (restricted `rsync`), add a line like this to your deploy user's `~/.ssh/authorized_keys` file, e.g. using `/var/www/` as the only valid target directory for deployment:

```txt
command="rrsync -wo /var/www/" ssh-ed25519 AAAAC3NzaC1...
```

Option `-wo` specifies write-only access for `rsync` from the client side; without that option, the client could also read files from the server, which is unnecessary and potentially insecure.

> [!IMPORTANT]
> Note that `rrsync` is picky about the target directory path.
> In the example above, the path ends with a slash (`/var/www/`), so the call of `rsync` in the GitLab CI job starts relative to that path: E.g, `example-book/` defined in this example's [.gitlab-ci.yml](.gitlab-ci.yml) would be copied into `/var/www/example-book/` on the server.
