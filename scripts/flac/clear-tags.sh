#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This operation will remove all tags of all flac files in a given directory.  Use with caution"
    echo
    echo "It will not remove any existing .tag or .bak files"
    echo
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "Required arguments:"
    echo
    echo "The name of the directory of flac files"
    echo
    echo "Optional argument:"
    echo
    echo "The name of a backup directory in which to save the current tags"
    echo "If this option is provided it will be used to save the current tags for each flac file"
    echo "You could then restore the tags with replace-tags.sh"
    exit 0
fi

dir="$1"

# echo "directory is  "$dir""
if [  ! -d "$dir" ]; then
  echo "The directory "$dir" does not exist"
  exit -2
fi
for file in "$dir"/*.flac
do
   metaflac --remove-all-tags "$file"
done






