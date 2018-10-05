#!/bin/bash

cd "$(dirname "$0")"
source common.bash

SKIP_DOWNLOAD=0
while getopts "nhr?" opt; do
    case $opt in
    n)
       SKIP_DOWNLOAD=1
       ;;
    r)
       result=$(docker ps -a | grep $maintainer/$imagename:$tag)
       if [ ! -z "$result" ]; then
         echo "Cleaning up $maintainer/$imagename:$tag..."
         docker rm -f $(docker ps -a | grep $maintainer/$imagename:$tag | awk '{print $1}')
         docker rmi -f $maintainer/$imagename:$tag
         echo "Done"
       fi
       ;;
    h | ?)
       echo "Options: -n skip download"
       exit 0
       ;;
    *)
       echo "Unknown option: $opt"
       exit 1
       ;;
    esac
done
if [ "$SKIP_DOWNLOAD" = "0" ]; then ./download-midpoint || exit 1; fi
docker build --tag $maintainer/$imagename:$tag --build-arg maintainer=$maintainer --build-arg imagename=$imagename . || exit 1
echo "---------------------------------------------------------------------------------------"
echo "The midPoint containers were successfully built. To start them, execute the following:"
echo ""
echo "(for simple demo)"
echo ""
echo "$ cd" $(pwd)/demo/simple
echo "$ docker-compose up"
echo ""
echo "(for complex demo)"
echo ""
echo "$ cd" $(pwd)/demo/complex
echo "$ docker-compose up --build"
