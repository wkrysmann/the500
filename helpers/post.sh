#!/bin/bash

postsDir="../_posts/"

# checking if argument supplied
if [ $# -ne 1 ]
  then
    echo "Wrong number of arguments supplied."
    exit 1
fi


function findAlbum {
# find album corresponding to given number
  local _album=`ls -1 ../bench/|grep "\-$1\."`

  if [ -z $_album ]; then
    echo "No such post!"
    exit 1
  else
    echo $_album
  fi
}

function buildName {
# build new name for release
  local date=`date +%Y-%m-%d`
  echo $date"-"$album
}

function createPostEntry {
# copy content from bench to production path
  if [ ! -f $postPath ]; then
    cp ../bench/$album $postPath
  else
    echo "Post already exists!"
    exit 1
  fi
}

function putDate {
# add date to file
  local date=`date '+%Y-%m-%d %H:%M:%S'`
  sed -i.bck -e "s/date:/date: $date/" $postPath && rm $postPath.bck
}

function commitToGit {
  git add $postPath
  git commit -m "created layout for $1 - $album"
}

album=$(findAlbum $1)
postName=$(buildName)
postPath=$postsDir$postName
createPostEntry
putDate
commitToGit
atom $postPath
