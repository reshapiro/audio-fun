This repository includes an number of convenient shell scripts for metaflac and sox.
Originally much of this was written in Java. That's still around but deprecated.
<h1>Flac</h1>

<h2>generate-metaflac</h2> 
This script tries to create basic metaflac tags from a directory of flac files that have no tags yet.

The required arguments are the metaflac directory and the flac directory, in that order.  The second is used to store a parallel collection of metaflac files and will be created if it doesn't exist yet.

Any number of other arguments in standard metaflac name=value form can be included as well, eg  ARTIST=Ornette\ Coleman.

The tags created for each file are as follows:

ALBUM: this is derived from basename of the flac directory.

TITLE: this is derived from the basename of the flac file, without the .flac suffix.

TRACKNUMBER: this is derived from position of the flac file in the list.

TRACKTOTAL: This is the total number of flac files.

The optional arguments will be added as is to each file.

Note that this script does not actually add the tags to flac files.  Its purpose is to provide an initial set of tag values in a separate file that can be edited manually before importing. To do the import, use **meta-flac-import** (see below).

<h2>meta-flac-import</h2>
This  script imports a directory of metaflac files into a parallel directory of flac files.

To run this the *metaflac* command must be on your PATH.

<h2>show-all-tags-in-directory</h2>
This script does what it says: displays all tags of all flac files in a given directory.

To run this the *metaflac* command must be on your PATH.

<h1>sox</h1>
The two 24-16 scripts use sox to resample high def audio  to 16/44.1 for use with systems like Sonos that don't support hi-def.

Invoke these on a directory of hi-def files.  The *sox* command must be on your PATH.

<h2>24-16-batch</h2>
This version writes the down-sampled files to to a parallel directory which must be provided as the second argument. This directory will be created if necessary.

<h2>24-16-inline</h2> 
This version <em>replaces</em> the existing files with the down-sampled version!  Use with caution!!









