#!/bin/zsh

# Erase file contents
echo -n "" > index.js

for FILE in $(ls icons-astro); do

    # Remove the suffix
    EXPORTNAME=${FILE%.astro}
    
    # If filename starts with a digit, prefix export name with "Icon"
    if [[ $FILE =~ ^[0-9] ]] && EXPORTNAME="Icon${EXPORTNAME}"

    echo "export { default as $EXPORTNAME } from '$FILE'" >> index.js 
done