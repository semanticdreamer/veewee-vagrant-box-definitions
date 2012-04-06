#!/bin/sh

#
# Accepts a Veewee definition directory name and
# creates and accordingly named Vagrant box 

BASENAME=$(basename $0)

VEEWEE_DEFINITIONS=$( ls -1 ./definitions | sed 's/^\(.*\)/"\1"/')

if [ -z "$1" ]; then
    echo "\nUsage:\n    $BASENAME veewee-definition"
    echo "\nAvailable Veewee definitions:\n"
    echo "${VEEWEE_DEFINITIONS[*]}\n"
    exit 1
fi

VEEWEE_DEFINITION="$1"
VEEWEE_DEFINITION_DIR="definitions/$VEEWEE_DEFINITION"
VAGRANT_BOX_FILE=$VEEWEE_DEFINITION".box"

if [ -d $VEEWEE_DEFINITION_DIR ]; then
    echo "******************************************************************\n"
    echo "  Building Vagrant '$VAGRANT_BOX_FILE'..."
    echo "\n******************************************************************"
else 
    echo "ERROR Veewee definition directory '$VEEWEE_DEFINITION_DIR' does not exist!"
    exit 1
fi

echo "\n\nStep 1 of 5: build Vagrant base box (overwrite an existing box if it exists)...\n\n"
vagrant basebox build --force --nogui $VEEWEE_DEFINITION

echo "\n\nStep 2 of 5: export Vagrant base box...\n\n"
vagrant basebox export $VEEWEE_DEFINITION

echo "\n\nStep 3 of 5: add box to local Vagrant...\n\n"
vagrant box add $VEEWEE_DEFINITION $VAGRANT_BOX_FILE

echo -n "\n\nStep 4 of 5 (OPTIONAL): Delete downloaded *.iso image file? (Yes/no) "
echo -n "Press ENTER for default one (Yes)\n\n"
read deleteiso
if [ -z "$deleteiso" ]
then
deleteiso=Yes
fi

if [ "$deleteiso" = "Yes" ]; then
    if [ -d "./iso/" ]; then
       rm -rf ./iso/
    fi
fi

echo -n "\n\nStep 5 of 5 (OPTIONAL): Delete Vagrant *.box file in working directory? (Yes/No) "
echo -n "Press ENTER for default one (Yes)\n\n"
read deletebox
if [ -z "$deletebox" ]
then
deletebox=Yes
fi

if [ "$deletebox" = "Yes" ]; then
    if [ -f $VAGRANT_BOX_FILE ]; then
       rm $VAGRANT_BOX_FILE
    fi
fi