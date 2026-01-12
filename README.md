<!--
  SPDX-FileCopyrightText: 2026 Johannes Keyser
  SPDX-License-Identifier: CC0-1.0
-->
# Quarto on Docker

A simple [Docker](https://www.docker.com/) image for [Quarto](https://quarto.org/), the scientific and technical publishing system built on [Pandoc](https://pandoc.org/).

![logo](./logo-quarto-on-docker.svg){width="150px"}

## Description

This project describes a Docker image that runs Quarto in a containerized environment.
It is primarily intended for use in continuous integration (CI) pipelines.

This image is simply (and probably not elegantly nor efficiently) based on a Debian image with the official Quarto installation.
It includes all necessary dependencies to run Quarto for documentation rendered as HTML and PDF, including SVG images.

Note that this image does not (yet?) include any programming environment such as R or Python.

## Installation

TODO

## Usage

TODO

## Support

TODO

## Roadmap

- Publish the Dockerfile.
- Document usage.
- _Maybe_ add support for more output formats (e.g., Word, EPUB)?
- _Maybe_ publish the image on Docker Hub?
- _Maybe_ add support for R and Python environments?

## Contributing

TODO

## Authors

- Johannes Keyser

## License

Except for logo(s), this project is licensed under the Creative Commons Zero v1.0 Universal (CC0-1.0) License.
For the plain legal text, see [LICENSES/CC0-1.0.txt](./LICENSES/CC0-1.0.txt).
For translations and a short, human-readable summary of the license, visit <https://creativecommons.org/publicdomain/zero/1.0/deed.en>.

## Project status

This project is under active development.
It is shared as-is, in the hope that it may be useful to others, without any guarantees or warranty.
