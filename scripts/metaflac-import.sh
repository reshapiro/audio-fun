#!/bin/sh
metaflacdir=$1
flacdir=$2

for file in "$flacdir"/*.flac
do
   base=`basename "$file" .flac`
   metaflacfile=${metaflacdir}/"${base}".mfl
   echo "importing $metaflacfile to $file"
   metaflac --import-tags-from="$metaflacfile" "$file"
done
