FROM node:22-bookworm

LABEL org.opencontainers.image.source="https://github.com/pixlcore/xyops-shell-image"
LABEL org.opencontainers.image.description="Base image for the xyOps Docker Event Plugin."
LABEL org.opencontainers.image.licenses="MIT"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	zip unzip xz-utils bzip2 procps lsof rsync \
    iputils-ping \
    dnsutils \
    openssh-client \
    net-tools \
    curl \
    wget \
    vim \
    less \
    sudo \
	iproute2 \
	tzdata \
	python3 \
	golang \
	git \
	ca-certificates \
	gnupg \
	ffmpeg \
	imagemagick \
	ghostscript \
	libwebp-dev \
	libheif1 \
	libjxl-tools \
	moreutils \
	jq

# install docker cli
RUN . /etc/os-release; \
  install -m 0755 -d /etc/apt/keyrings; \
  curl -fsSL "https://download.docker.com/linux/$ID/gpg" -o /etc/apt/keyrings/docker.asc; \
  chmod a+r /etc/apt/keyrings/docker.asc; \
  ARCH=$(dpkg --print-architecture); \
  echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/$ID ${UBUNTU_CODENAME:-$VERSION_CODENAME} stable" \
  > /etc/apt/sources.list.d/docker.list; \
  apt-get update && apt-get install -y --no-install-recommends docker-ce-cli;

# cleanup apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# install xyrun
RUN npm install -g @pixlcore/xyrun

WORKDIR /opt/xyops

CMD ["xyrun"]
