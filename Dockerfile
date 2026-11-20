# PURPOSE: A simple Docker image to use Quarto in CI/CD pipelines.
# AUTHORS: Johannes Keyser <johannes.keyser@uni-hamburg.de>
# LICENSE: CC0-1.0 (Creative Commons Zero v1.0 Universal)
# SPDX-FileCopyrightText: 2026 Johannes Keyser <johannes.keyser@uni-hamburg.de>
# SPDX-License-Identifier: CC0-1.0

FROM debian:trixie-slim

# NOTE: When changing a version, also update its SHA256 checksum, as published
#       with the release (Quarto: quarto-VERSION-checksums.txt on GitHub;
#       glab: checksums.txt on GitLab); the build fails if they don't match.
ARG QUARTO_VERSION=1.11.9
ARG QUARTO_SHA256=64078d1623d9ab89da766591f3410a0756f3737a37efb0897c7e84b863bf092a
ARG GLAB_VERSION=1.131.0
ARG GLAB_SHA256=e9e841f4bc62dfb0d6c30ada0aa70e22d9bb4879eba7571ef54998912cebe9ed

# Install required tools;
# note librsvg2-bin for SVG to PDF conversion,
# and python3 for helper scripts in CI jobs (not for Python code cells)
RUN apt-get update && apt-get install -y --no-install-recommends \
      bash \
      curl \
      tar \
      xz-utils \
      librsvg2-bin \
      ca-certificates \
      ssh \
      rsync \
      python3 \
    && rm -rf /var/lib/apt/lists/*

# Install glab
RUN curl -fsSL -o /tmp/glab.deb "https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.deb" \
    && echo "${GLAB_SHA256}  /tmp/glab.deb" | sha256sum -c - \
    && apt-get update \
    && apt-get install -y /tmp/glab.deb \
    && rm /tmp/glab.deb \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto using the Debian package from GitHub releases.
RUN curl -fsSL -o /tmp/quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && echo "${QUARTO_SHA256}  /tmp/quarto.deb" | sha256sum -c - \
    && apt-get update \
    && apt-get install -y /tmp/quarto.deb \
    && rm /tmp/quarto.deb \
    && rm -rf /var/lib/apt/lists/*

# Install TinyTeX for LaTeX PDF output (note that Typst comes bundled with Quarto).
RUN quarto install tinytex

ENV PATH="/opt/quarto/${QUARTO_VERSION}/bin:${PATH}"

CMD ["quarto"]
