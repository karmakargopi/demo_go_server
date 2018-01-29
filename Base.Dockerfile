 # @author [Gopi Karmakar]
 # @email [gopi.karmakar@monstar-lab.com]
 # @create date 2018-01-26 05:02:02
 # @modify date 2018-01-26 05:02:02
 # @desc [description]
 
ARG GOLANG_TAG
FROM golang:${GOLANG_TAG}

# Stuff needed for dep in alpine
RUN apk --update add git openssh curl && \
  rm -rf /var/lib/apt/lists/* && \
  rm /var/cache/apk/*

# install dep
RUN curl -fsSL -o /usr/local/bin/dep https://github.com/golang/dep/releases/download/v0.3.2/dep-linux-amd64 && chmod +x /usr/local/bin/dep

# Copy the local package files to the container's workspace.
ARG APP_NAME
WORKDIR /go/src/${APP_NAME}
ADD app ./app

# Install dependencies
RUN dep init -v
#RUN dep ensure -vendor-only

#copies the Gopkg.toml and Gopkg.lock to WORKDIR
ADD Gopkg.toml Gopkg.lock ./