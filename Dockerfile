FROM node:10.4.1
MAINTAINER olizilla <oli@tableflip.io>
ENV NPM_CONFIG_LOGLEVEL info

# Install and init ipfs
WORKDIR /tmp
RUN wget https://dist.ipfs.io/go-ipfs/v0.4.17/go-ipfs_v0.4.17_linux-amd64.tar.gz && tar -xzf go-ipfs_v0.4.17_linux-amd64.tar.gz && mv go-ipfs/ipfs /usr/local/bin
RUN ipfs init

# Get the webui deps
WORKDIR /src
COPY package.json package-lock.json /src/
RUN npm ci

# Build webui and add to ipfs
COPY . /src/
RUN npm run build && ipfs add -r -Q build
