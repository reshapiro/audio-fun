<h2>export-tags</h2> 
This script exports extant metaflac tags from a directory of flac files.

The required arguments are a directory of flac files and a second directory to store the tag files. The tag directory will be created if it doesn't exist yet.
Normally the tags directory should *not* exist, but you can append to an existing one if you like.

To run this the metaflac command must be on your PATH.


<h2>generate-tags</h2> 
This script tries to create basic metaflac tags from a directory of flac files that have no tags yet.

The required arguments are a directory of flac files and a second directory to store the tag files. The tag directory will be created if it doesn't exist yet.
Normally the tags directory should *not* exist, but you can append to an existing one if you like.

Any number of other arguments in standard metaflac name=value form can be included as well, eg  ARTIST=Ornette\ Coleman.

The tags created for each file are as follows:

ALBUM: this is derived from basename of the flac directory.

TITLE: this is derived from the basename of the flac file, without the .flac suffix.

TRACKNUMBER: this is derived from position of the flac file in the list.

TRACKTOTAL: This is the total number of flac files.

The optional arguments will be added as is to each file.

Note that this script does not actually add the tags to flac files.  Its purpose is to provide an initial set of tag values in a separate files that can be edited manually before importing. To do the import, use **import-tags** (see below).

<h2>import-tags</h2>
This  script imports a directory of tag files into a parallel directory of flac files.
The arguments are the tags directory and the flac directory.

To run this the *metaflac* command must be on your PATH.

<h2>show-all-tags-in-directory</h2>
This script displays all tags of all flac files in a given directory.

It has one required argument, the name of the flac directory.

To run this the *metaflac* command must be on your PATH.

<h1>sox</h1>

<h2>down-sample</h2>

This script will down-sample a directory of hi-def audio files, saving the results to a parallel directory.

Use this if you have hi-def files but a player that only supports standard CD quality.

It has two required arguments, a directory of hi-def audio files and directory to store the down-sampled files.

By default the sample rate is 44100 and the sample size is 16

To use a different values, provide them in that order as optional arguments.




