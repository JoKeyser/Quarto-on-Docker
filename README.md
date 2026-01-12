<!--
  SPDX-FileCopyrightText: 2026 Johannes Keyser
  SPDX-License-Identifier: CC0-1.0
-->
# Quarto on Docker

A simple [Docker](https://www.docker.com/) image for [Quarto](https://quarto.org/), the scientific and technical publishing system built on [Pandoc](https://pandoc.org/).

![nice silly logo for quarto-on-docker](./logo-quarto-on-docker.svg)

## Description

This project describes a Docker image that runs Quarto in a containerized environment.
It is primarily intended for use in continuous integration (CI) pipelines.

This image is simply (and probably not elegantly nor efficiently) based on a Debian image with the official Quarto installation.
It includes all necessary dependencies to run Quarto for documentation rendered as HTML and PDF, including SVG images.

> [!NOTE]
> This image does not (yet?) include any programming environment such as R or Python.
> This may be added in the future, depending on our own demand.

## Installation

TODO

## Usage

TODO

## Support

This image is tested on GitLab CI.

It includes the dependencies to run Quarto for documentation rendered as HTML and PDF, including SVG images.

> [!TIP]
> You can locally test your GitLab CI configuration with [GitLab-CI-Local](https://github.com/firecow/gitlab-ci-local).

## Roadmap

- Publish the Dockerfile.
- Document usage.
- _Maybe_ add support for more output formats (e.g., Word, EPUB)?
- _Maybe_ publish the image on Docker Hub?
- _Maybe_ add support for R and Python environments?

## Contributing

Contributions are welcome!
Feel free to open issues and submit pull requests, either [on GitHub](https://github.com/JoKeyser/Quarto-on-Docker) or [UHH's GitLab instance](gitlab.rrz.uni-hamburg.de/bbf2281/quarto-on-docker).

## Authors

- Johannes Keyser

## License

Except for logo(s), this project is licensed under the Creative Commons Zero v1.0 Universal (CC0-1.0) License.
For the plain legal text, see [LICENSES/CC0-1.0.txt](./LICENSES/CC0-1.0.txt).
For translations and a human-readable summary of the license, visit <https://creativecommons.org/publicdomain/zero/1.0/>.

## Project status

This project is under active development.
It is shared as-is, in the hope that it may be useful to others, without any guarantees or warranty.
