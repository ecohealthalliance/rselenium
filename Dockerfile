FROM rocker/verse:latest

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends --no-upgrade \
     bzip2 curl \
  && install2.r RSelenium \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

RUN set -x \
  && VER="17.03.0-ce" \
  && curl -L -o /tmp/docker-$VER.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$VER.tgz \
  && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
  && mv /tmp/docker/* /usr/bin

USER rstudio

RUN Rscript -e "wdman:::selenium()"

USER root
