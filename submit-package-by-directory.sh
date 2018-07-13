#!/bin/bash

################
#
# submit-package-by-directory.sh
#
# Use from /home/bcodmo: sudo doi/submit-package-by-directory.sh dataset_xxxxxx 
#   where a dataset_xxxxxx is a directory in /home/bcodmo/imports
#
################

# CONSTANTS
SRC=/home/bcodmo
SUBMITTER=bcodmo@gmail.com
# the BCO-DMO Collection is 1912/4135
COLLECTION=1912/4135

# The name of the ZIP file at /home/bcodmo to submit
DIR=$1
DATASET_DIR=$SRC/imports/$DIR
HANDLE_FILE=$DIR.handle

### RUN THE IMPORT
# submit the package to DSPACE - NB: must be run as root
/dspace/bin/dspace import --add --eperson=$SUBMITTER --collection=$COLLECTION --source=$DATASET_DIR --mapfile=$HANDLE_FILE

# Cleanup
#rm -rf $DATASET_DIR

# read the handle file
FILE_TEXT=`cat $HANDLE_FILE`
echo $FILE_TEXT
for word in $FILE_TEXT
do
   HANDLE_ID=$word
done
RESOURCE=http://hdl.handle.net/$HANDLE_ID
echo $RESOURCE

# Cleanup Submission files
mv $HANDLE_FILE $SRC/doi/handles/$HANDLE_FILE

