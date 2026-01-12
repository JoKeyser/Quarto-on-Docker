<!--
  SPDX-FileCopyrightText: 2026 Johannes Keyser
  SPDX-License-Identifier: CC0-1.0
-->
# Quarto on Docker

A simple [Docker](https://www.docker.com/) image for [Quarto](https://quarto.org/), the scientific and technical publishing system built on [Pandoc](https://pandoc.org/).

![nice silly logo for quarto-on-docker](./logo-quarto-on-docker.svg)

## Description

This project [describes a Docker image](./Dockerfile) that runs Quarto in a containerized environment.
It is intended for use in continuous integration/continuous deployment (CI/CD).

This image is simply based on a Debian image with the official Quarto installation.
It includes all necessary dependencies to run Quarto for documentation rendered as HTML and PDF, including SVG images.
It is probably not very elegant or efficient, but gets the (CI/CD) job done 🤓.

> [!NOTE]
> This image does not (yet?) include any programming environment such as R or Python.
> This may be added in the future, depending on our own demand.

## Usage

You can use the built Docker image in your GitLab CI pipelines to render Quarto documents.
(Or you can build and register your own, customized image, see [Installation](#installation) section below.)

> [!NOTE]
> On UHH GitLab, you can use Docker images with the RRZ's shared GitLab runner.
> To do so, in your project settings, enable the option _"Turn on instance runners for this project"_ under _Settings → CI/CD → Runners → Instance runners_.

To avoid confusion, let's call the project where you want to use Quarto the _"target project"_, and the project where the built/registered Docker image is hosted the _"image project"_.

In the "target project", specify the Docker image in your `.gitlab-ci.yml` file, pointing to the image's URL registered in the "image project".
For example, with a project hosted on UHH's GitLab instance, you can use a configuration like this:

```yaml
image: gitlab.rrz.uni-hamburg.de:4567/bbf2281/quarto-on-docker/image:latest
# NOTE: Replace bbf2281 with your own UHH user ID, or the appropriate group ID and project path, as configured during the image registration, see Installation section.
stages:
  - build
build_quarto_docs:
  stage: build
  script:
    - quarto render
```

> [!NOTE]
> On GitLab, your "target project" must authenticate with the container registry to pull the Docker image from the "image project".
> If your "target project" is in a different namespace, you must add it (or its entire group) to the _Job token allowlist_ settings in the "image project" under _Settings → CI/CD → Job token permissions_.

## Installation

> [!NOTE]
> To use this image in GitLab CI, no installation is necessary on your local machine, see [Usage](#usage) section for details.
> Only proceed with the steps below if you want to build the image locally.

0. Make sure you have [Docker](https://www.docker.com/) installed.
1. Clone or copy this repository.
2. Build the Docker image with the following command:

   ```sh
   docker build -t MY-IMAGE-NAME:my-tag .
   ```

   Note to tag the image, you should change the `-t` argument accordingly.
   For example, if you want to push the image to a GitLab container registry, you have to tag it with the appropriate URL, e.g., like this:

   ```sh
   docker build -t gitlab.rrz.uni-hamburg.de:4567/bbf2281/quarto-on-docker/image:latest .
   ```

3. If the build succeeds, you can locally test the image by running the `quarto check`.
   It should print the installed Quarto version and some system information.

   ```sh
   docker run --rm -it MY-IMAGE-NAME:my-tag quarto check
   ```

4. If all works fine, you can publish your image on GitLab's container registry.
   Note that you need to be logged in to GitLab's container registry (e.g., via `docker login`).
   Make sure to replace `bbf2281` with your own UHH user ID, or the appropriate group ID and project path.
   Here an example command to tag and push the image:

   ```sh
   docker push gitlab.rrz.uni-hamburg.de:4567/bbf2281/quarto-on-docker/image:latest
   ```

Now you can use the built image in your GitLab CI pipelines as described in the [Usage](#usage) section.

## Support

This image was built on Ubuntu 24.04 and tested on GitLab CI with the Docker executor.

It includes the dependencies to run Quarto to render into HTML and PDF, including SVG images.

> [!TIP]
> You can locally test your GitLab CI configuration with [GitLab-CI-Local](https://github.com/firecow/gitlab-ci-local).

## Roadmap

- _Maybe_ publish the Dockerfile?
- _Maybe_ add support for more output formats (e.g., Word, EPUB)?
- _Maybe_ publish the image on Docker Hub?
- _Maybe_ add support for R and Python environments?

## Contributing

Contributions are welcome.
Feel free to open issues and submit pull requests, either [on GitHub](https://github.com/JoKeyser/Quarto-on-Docker) or [UHH's GitLab instance](gitlab.rrz.uni-hamburg.de/bbf2281/quarto-on-docker).

## Authors

- Johannes Keyser <johannes.keyser@uni-hamburg.de>

## License

Except for logo(s), this project is licensed under the Creative Commons Zero v1.0 Universal (CC0-1.0) License.
For the plain legal text, see [LICENSES/CC0-1.0.txt](./LICENSES/CC0-1.0.txt).
For translations and a human-readable summary of the license, visit <https://creativecommons.org/publicdomain/zero/1.0/>.

## Project status

This project is under active development.
It is shared as-is, in the hope that it may be useful to others, without any guarantees or warranty.
