#!/bin/bash

list="list.txt" #list of albums
notReleasedDir="../bench"

function noExtSpace {
	local noExtSpace="$(echo -e $1 | sed -e 's/^[[:space:]]//' -e 's/[[:space:]]$//')"
	echo $noExtSpace
}

function spaceToUnderscore {
	local spaceToUnderscore="$(echo -e $1 | sed -e 's/[^a-zA-Z0-9\-]/_/g')"
	echo $spaceToUnderscore
}
function checkLastSign {
	local checkLastSign="$(echo -e $1 | sed -e 's/[^[:alnum:]]$//')"
	echo $checkLastSign
}

function prepareInfo {
	number=$(noExtSpace "`echo $line | cut -d . -f1`")
	local _artist=$(noExtSpace "`echo $line | cut -f2- -d"."|cut -d - -f1`")
	local _album=$(noExtSpace "`echo $line | cut -d - -f2`")

	_artist=$(checkLastSign "$_artist")
	_album=$(checkLastSign "$_album")

	artist=$_artist
	album=$_album
	
	local _artistUrl=$(spaceToUnderscore "$_artist")
	local _albumUrl=$(spaceToUnderscore "$_album")

	artistUrl=$_artistUrl
	albumUrl=$_albumUrl
}

function prepareURL {
	URL=`echo $artistUrl"-"$albumUrl"-"$number".markdown"`
}

function getSpotifyURL {
	return
}

function getGoogleImg {
	return
}

function _echo {
	echo $1 >> $notReleasedDir/$URL
}
function writeContent {
	_echo "---"
	_echo "title: \"$artist - $album\""
	_echo "subtitle: \"$number\""
	_echo "author: \"kryss\""
	_echo "avatar: \"img/authors/kryss.jpg\""
	_echo "image: \"img/$number.jpg\""
	_echo "date:"
	_echo "---"
	_echo ""
	_echo "### $artist - $album"
}

while read line
do

	prepareInfo
	prepareURL
	#getSpotifyURL
	#getGoogleImg
	> $notReleasedDir/$URL #create or clear file
	writeContent $notReleasedDir/$URL

done < $list
