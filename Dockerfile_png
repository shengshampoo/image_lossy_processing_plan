FROM alpine:latest

# https://mirrors.alpinelinux.org/
RUN sed -i 's@dl-cdn.alpinelinux.org@ftp.halifax.rwth-aachen.de@g' /etc/apk/repositories

RUN apk update
RUN apk upgrade

RUN apk add --no-cache \
  bash curl xz tar graphicsmagick

# image from Distrowatch screenshot Gallery
RUN curl --create-dirs --output /images/fedora.png https://distrowatch.com/images/slinks/fedora.png && \
    curl --create-dirs --output /images/kali.png https://distrowatch.com/images/slinks/kali.png && \
    curl --create-dirs --output /images/endeavour.png https://distrowatch.com/images/slinks/endeavour.png && \
    curl --create-dirs --output /images/chimera.png https://distrowatch.com/images/slinks/chimera.png && \
    curl --create-dirs --output /images/mx.png https://distrowatch.com/images/slinks/mx.png 

ENV XZ_OPT=-e9
COPY images images
COPY pngquant zopflipng rust-parallel image_lossy_processing_png.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/* && bash /usr/local/bin/image_lossy_processing_png.sh
