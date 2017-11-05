#!/bin/bash

postsDir="../_posts/"

if [ $# -ne 1 ]
  then
    echo "Wrong number of arguments supplied."
    exit 1
fi

function findAlbum {
  local _album=$(ls -1 ../bench/|grep "\-$1\.")
  echo $_album
}

function buildName {
  local date=`date +%Y-%m-%d`
  echo $date"-"$album
}

function createPostEntry {
  if [ ! -f $postPath ]; then
    cp ../bench/$album $postPath
  else
    echo "Post already exists!"
    exit 1
  fi
}

function putDate {
  local date=`date '+%Y-%m-%d %H:%M:%S'`
  sed -i -e "s/date:/date: $date/" $postPath
}

album=$(findAlbum $1)
postName=$(buildName)
postPath=$postsDir$postName
createPostEntry
putDate
