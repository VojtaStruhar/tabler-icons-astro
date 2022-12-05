#!/bin/zsh

ICONS_FOLDER="./icons-astro"

# Erase file contents
echo -n "" > index.js

for FILE in $(ls $ICONS_FOLDER); do

    # Remove the suffix
    EXPORTNAME=${FILE%.astro}
    
    # If filename starts with a digit, prefix export name with "Icon"
    if [[ $FILE =~ ^[0-9] ]] && EXPORTNAME="Icon${EXPORTNAME}"

    echo "export { default as $EXPORTNAME } from '$ICONS_FOLDER/$FILE'" >> index.js 
done