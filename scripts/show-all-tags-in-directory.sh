#!/bin/sh
dir=$1
for file in "$dir"/*.flac
do
   base=`basename "$file"`
   echo "$base:"
   echo
   metaflac --export-tags-to=- "$file"
   echo
   echo
done






