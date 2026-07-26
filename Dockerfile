# PURPOSE: A simple Docker image to use Quarto in CI/CD pipelines.
# AUTHORS: Johannes Keyser <johannes.keyser@uni-hamburg.de>
# LICENSE: CC0-1.0 (Creative Commons Zero v1.0 Universal)
# SPDX-FileCopyrightText: 2026 Johannes Keyser <johannes.keyser@uni-hamburg.de>
# SPDX-License-Identifier: CC0-1.0

FROM debian:trixie-slim

ARG QUARTO_VERSION=1.10.18
ARG GLAB_VERSION=1.109.0

# Install required tools;
# note librsvg2-bin for SVG to PDF conversion
RUN apt-get update && apt-get install -y --no-install-recommends \
      bash \
      curl \
      tar \
      xz-utils \
      librsvg2-bin \
      ca-certificates \
      ssh \
      rsync \
    && rm -rf /var/lib/apt/lists/*

# Install glab
RUN curl -fsSL -o /tmp/glab.deb "https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.deb" \
    && apt-get update \
    && apt-get install -y /tmp/glab.deb \
    && rm /tmp/glab.deb \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto using the Debian package from GitHub releases.
RUN curl -fsSL -o /tmp/quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb" \
    && apt-get update \
    && apt-get install -y /tmp/quarto.deb \
    && rm /tmp/quarto.deb \
    && rm -rf /var/lib/apt/lists/*

# Install TinyTeX for LaTeX PDF output (note that Typst comes bundled with Quarto).
RUN quarto install tinytex

ENV PATH="/opt/quarto/${QUARTO_VERSION}/bin:${PATH}"

CMD ["quarto"]
