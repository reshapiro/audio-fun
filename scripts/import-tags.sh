#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Two arguments are required."
    echo
    echo "The first argument should be a directory containing tags files."
    echo "The second argument should be a parallel directory containing flac files"
    exit -1
fi

metaflacdir=$1
flacdir=$2

for file in "$flacdir"/*.flac
do
   base=`basename "$file" .flac`
   metaflacfile=${metaflacdir}/"${base}".mfl
   echo "importing $metaflacfile to $file"
   metaflac --import-tags-from="$metaflacfile" "$file"
done
