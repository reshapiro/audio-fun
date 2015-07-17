#!/bin/sh

if [ $# -lt 2 ]; then
    echo
    echo "This operation down-samples an audio file saving the result to elsewhere"
    echo "Use this if you have a hi-def audio file you want to hear through a player or DAC that only supports CD quality audio"
    echo 
    echo "This operation requires sox to be on your PATH"
    echo
    echo "Required arguments:"
    echo
    echo "The audio file to be down-sampled."
    echo "The file path for the resulting down-sampled file"
     echo "Supported formats are aiff, wav and flac. Anything else will fail.
    echo
    echo "Optional arguments: note for now order is significant"
    echo
    echo "The desired sample rate. The default is 44100"
    echo "If the original file has a rate of 96000 and 192000 you might get better results with 48k instead of 44100"
    echo
    echo "The desired sample size. The default is 16"
    exit 0
fi
input="$1"
output="$2"
#default rate and size

rate=44100
size=16

if [ $# -gt 2 ]; then
   rate=$3
fi

if [ $# -gt 3 ]; then
   size=$4
fi

if [  ! -f "$input" ]; then
	echo "The file "$input" does not exist"
	exit -2
fi

if [  -f "$output" ]; then
	echo "cowardly refusing to clobber existing file "$output"  "
	exit -1
fi

sox -S "${input}" -r $rate -b $size "$output" dither -s

