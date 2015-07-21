#!/bin/sh

if [ $# -lt 1 ]; then
    echo
    echo "This operation tries to generate and save flac tags given a directory of flac files."
    echo "On completion all the flac files should have tags for at least ALBUM, TITLE,TRACKNUMBER and TRACKTOTAL"
    echo "The directory will also contain a .tag file for each .flac file. These can be used later to add, edit or delete tag values"
    echo "If you don't want to keep the .tag files around, simply delete *.tag. They can be recreated with save-flac-tags" 
    echo "To run this the metaflac command must be on your PATH."
    echo
    echo "The tag generation logic is as follows:"
    echo
    echo "The ALBUM tag is derived form the basename of flac directory."
    echo  "The TITLE tag is derived from the basename of each flac file, sans .flac suffix."
    echo "The TRACKNUMBER tag is derived from the position of the flac file in the directory"
    echo "The TRACKTOTAL tag is derived from the number of flac files in the directory"
    
    echo
    echo "Required arguments:"
    echo
    echo "The name of the directory of flac files"
    echo
    echo "Optional arguments:"
    echo
    echo "You can add any number of other arguments in name=value form where name is a flac tag, for instance ARTIST=Bob\ Dylan"
    echo "If a value includes whitespace it must be quoted, as in example above"
    exit 0
fi

flacdir="$1"

if [  ! -d "$flacdir" ]; then
  echo "The directory $flacdir does not exist"
  exit -2
fi

#compute the track count
total=0
for f in "$flacdir"/*.flac
 do
   total=`expr $total + 1`
 done

# generate the initial .tag files
index=1
album=`basename "$flacdir"`
for f in "$flacdir"/*.flac
 do
#  echo " file is $f"
  base=`basename "$f" ".flac"`
# echo " basename is  $base"
  tagsfile="$flacdir"/"$base".tag
#  echo "mf file is "$tagsfile""
  echo "TITLE"=$base"" >> "$tagsfile"
  echo "TRACKNUMBER=$index" >> "$tagsfile"
  echo "TRACKTOTAL=$total" >> "$tagsfile"
  echo "ALBUM=$album" >> "$tagsfile"
  
  
  
  # add optional tags to each tag file
  vardex=1
  for var in "$@"
  do
   if [ $vardex -ge 2 ]; then 
     echo "$var" >> "$tagsfile"
   fi
    vardex=`expr $vardex + 1`
  done
  
  
  index=`expr $index + 1`
done


# import tags to eacg flac file
for file in "$flacdir"/*.flac
do
   base=`basename "$file" .flac`
   tagsfile=${flacdir}/"${base}".tag
#   echo "importing $tagsfile to $file"
   metaflac --import-tags-from="$tagsfile" "$file"
done
