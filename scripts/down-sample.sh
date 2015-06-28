#!/bin/sh

if [ $# -lt 2 ]; then
    echo
    echo "This operation down-samples each audio file in a given directory, saving the results to a parallel directory"
    echo "Use this if you have hi-def audio files you want to hear through a player or DAC that only supports CD quality audio"
    echo 
    echo "This operation requires sox to be on your PATH"
    echo
    echo "Required arguments:"
    echo
    echo "The directory of audio files to be down-sampled."
    echo "The directory in which the down-sampled files will be saved. It will be created if it doesn't exit yet"
    echo
    echo "Optional arguments:"
    echo
    echo "The desired sample size. The default is 16"
    echo "The desired sample rate. The default is 44100"
    echo "If the original file has a rate or 96000 and 192000 you might get better results with 48k instead of 44100"
    exit 0
fi
dir="$1"
newdir="$2"
#default rate and size

rate=44100
size=16

if [ $# -gt 2 ]; then
   rate=$3
fi

if [ $# -gt 3 ]; then
   size=$4
fi

if [  ! -d "$dir" ]; then
  echo "The directory "$dir" does not exist"
  exit -2
fi

mkdir -p $newdir
for file in "$dir"/*.flac
do
   fname=`basename "${file}"`
   new="$newdir"/"$fname"
   echo "convert "$file" to "$new"" 
    sox -S "${file}" -r $rate -b $size "$new" dither -s
done






