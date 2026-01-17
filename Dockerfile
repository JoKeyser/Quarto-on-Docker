# PURPOSE: A simple Docker image to use Quarto in CI/CD pipelines.
# AUTHORS: Johannes Keyser <johannes.keyser@uni-hamburg.de>
# LICENSE: CC0-1.0 (Creative Commons Zero v1.0 Universal)

FROM debian:trixie-slim

ARG QUARTO_VERSION=1.8.26

# Install required tools;
# note librsvg2-bin for SVG to PDF conversion
RUN apt-get update && apt-get install -y --no-install-recommends \
      bash \
      curl \
      tar \
      librsvg2-bin \
      ca-certificates \
      ssh \
      rsync \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto, based on official instructions
# at <https://docs.posit.co/resources/install-quarto.html>
RUN mkdir -p /opt/quarto/${QUARTO_VERSION} \
    && curl -fsSL -o /tmp/quarto.tar.gz \
	 "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz" \
    && tar -xzf /tmp/quarto.tar.gz \
       -C "/opt/quarto/${QUARTO_VERSION}" \
       --strip-components=1 \
    && rm /tmp/quarto.tar.gz \
    && ln -s /opt/quarto/${QUARTO_VERSION}/bin/quarto /usr/local/bin/quarto

# Install TinyTeX for PDF output
RUN quarto install tinytex

ENV PATH="/opt/quarto/${QUARTO_VERSION}/bin:${PATH}"

CMD ["quarto"]
