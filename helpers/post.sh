#!/bin/bash

postsDir="../_posts/"

function checkoutGit {
  git checkout master
  git pull
}

function prepare {
# checking if arguments supplied, or calculating which post is next
  if [ $# -eq 0 ]; then
    newPost=`expr $(lastPublishedPost) - "1"`
  elif [ $# -eq 1 ]; then
    newPost=$1
  else
    echo "Too many arguments passed!"
    exit 1
  fi
}

function lastPublishedPost {
# find last posted album
  local _recentPost=`ls -1 ../_posts/|awk -F- '{print $6}'|awk -F. '{print $1}'|sort -nr|grep -v "^$"|tail -n1`
  echo $_recentPost
}

function findAlbum {
# find album corresponding to given number
  local _album=`ls -1 ../bench/|grep "\-$newPost\."`

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
# copy content from bench to production path and checking if post doesn't exist already
  local _existsWithDifferentDate=`ls -1 ../_posts/|grep "\-$newPost\."`

  if [ -f $postPath ]; then
    echo "Post already exists (with today's date)!"
    exit 1
  elif [ ! -z $_existsWithDifferentDate ]; then
    echo "Post already exists (with different date)!"
    exit 1
  else
    cp ../bench/$album $postPath
  fi
}

function putDate {
# add date to file
  local date=`date '+%Y-%m-%d %H:%M:%S'`
  sed -i.bck -e "s/date:/date: $date/" $postPath && rm $postPath.bck
}

function commitToGit {
  git add $postPath
  git commit -m "created layout for $newPost - $album"
}

#checkoutGit
prepare
album=$(findAlbum $newPost)
postName=$(buildName)
postPath=$postsDir$postName
createPostEntry
putDate
commitToGit
atom $postPath
