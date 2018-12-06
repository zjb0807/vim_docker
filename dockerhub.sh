#!/bin/bash
set -e

version=1.0.3
docker build . -f Dockerfile -t zjb0807/vim:"$version"
#docker build . -f Dockerfile --no-cache -t zjb0807/vim:"$version"

docker tag zjb0807/vim:"$version" zjb0807/vim:latest
docker tag zjb0807/vim:"$version" vim:latest

#docker login
#docker push zjb0807/vim:"$version"
#docker push zjb0807/vim:latest
