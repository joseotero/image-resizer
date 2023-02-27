#!/bin/bash
rm -rf build/image build/*.zip
docker build -t image-resizer-builder . --build-arg NODE_ENV=production --build-arg NODE_PATH=./node_modules --build-arg APP_PATH=/image
docker run -it --name builder image-resizer-builder
docker cp builder:/image ./build
docker rm builder