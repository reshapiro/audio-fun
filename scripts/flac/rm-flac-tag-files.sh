#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This operation will remove all .tag files in a flac directory"
    echo " When the .tag files are removed you can no longer revert the to the previous set of tags"
    echo
    echo
    echo "Required arguments:"
    echo
    echo "The name of the directory of flac files"
    echo
    exit 0
fi

dir="$1"

if [  ! -d "$dir" ]; then
  echo "The directory "$dir" does not exist"
  exit -2
fi
rm "$dir"/*.tag

