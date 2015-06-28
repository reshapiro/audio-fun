#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This operation will remove all tags of all flac files in a given directory"
    echo
    echo "Use with caution!"
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

save=0
if [ $# -gt 1 ]; then
   save=1
   backupdir="$2"
   mkdir -p "$backupdir"
fi

for file in "$dir"/*.flac
do
   base=`basename "$file" .flac`
   if [ $save -gt 0 ]; then
   backupfile="$backupdir"/"$base".tag
      metaflac --export-tags-to="$backupfile" "$file"
   
   fi
   metaflac --remove-all-tags "$file"
done






