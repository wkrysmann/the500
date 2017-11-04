#!/bin/bash

list="list.txt" #list of albums

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

function prepareURL {
echo .
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

	artist=$_artist
	album=$_album
	artistUrl=$_artistUrl
	albumUrl=$_albumUrl
	echo $number; echo $artistUrl; echo $albumUrl
	echo $artist; echo $album
}

function getSpotifyURL {
return
}

function getGoogleImg {
return
}

function writeContent {
	_echo "---"
	_echo "title: \"" -n; _echo $artist -n; _echo "\""
	_echo "subtitle: "
	_echo "---"
}

while read line
do

	prepareInfo
	getSpotifyURL
	getGoogleImg
	#writeContent
done < $list
