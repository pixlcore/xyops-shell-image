# xyOps Shell Image

This repository generates a Docker base image for the [xyOps](https://xyops.io) [Docker Plugin](https://xyops.io/docs/plugins/docker-plugin).  It uses the [xyRun](https://github.com/pixlcore/xyrun) utility to run custom xyOps job scripts inside the container, while handling things like monitoring system resources, and handling file upload/download.

You can use this image directly in your xyOps jobs, as it comes preinstalled with a variety of popular software, but more likely you will want to create your own Docker image based on this one, and pull in your own dependencies.  Instructions are below.

# Preinstalled

The image is based on `node:22-bookworm` (Debian 12) and contains the following preinstalled software:

- Node.js v22 + NPM + NPX
- Python v3 + UV + UVX
- Docker CLI
- ffmpeg
- ImageMagick +WebP +AVIF +HEIC +JPEG-XL
- [xyRun](https://github.com/pixlcore/xyrun)
- Also: zip, git, ssh, curl, wget, vim, less, sudo, jq, moreutils

# Custom Image

To make your own custom image based on this one, set your Dockerfile `FROM` line to:

```
FROM ghcr.io/pixlcore/xyops-shell-image:latest
```

Or, you can use any base image you want.  Just make sure [xyRun](https://github.com/pixlcore/xyrun) is preinstalled and launched as your `CMD` or `ENTRYPOINT`.

In your Dockerfile, preinstall Node.js LTS if not already there (assuming Ubuntu / Debian base):

```
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash
RUN apt-get update && apt-get install -y nodejs
```

And preinstall xyRun like this:

```
RUN npm install -g @pixlcore/xyrun
```

Then set your `CMD` like this:

```
CMD ["xyrun"]
```

xyRun will then launch your custom script specified in your xyOps event, monitor all system resources during job runs, and handle uploading and downloading files for your jobs.

# License

MIT
