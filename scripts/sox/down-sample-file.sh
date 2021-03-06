#!/bin/sh

if [ $# -lt 2 ]; then
    echo
    echo "This operation down-samples an audio file saving the result elsewhere"
    echo "Use this if you have a hi-def audio file you want to hear through a player or DAC that only supports CD quality audio"
    echo 
    echo "This operation requires sox to be on your PATH"
    echo
    echo "Required arguments:"
    echo
    echo "The audio file to be down-sampled.  Must be aiff, wav or flac"
    echo "The file path for the resulting down-sampled file.  This file should _not_ exist yet: an existing will never be overridden"
    echo
    echo "The suffix of the down-sampled file  path specifies what audio format it will be in"
    echo "For example if the source file is wav and the destination file path is foo.flac, the resulting file will be flac, not wav"
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
	echo "Cowardly refusing to clobber existing file "$output"  "
	exit -1
fi

sox -S "${input}" -r $rate -b $size "$output" dither -s

