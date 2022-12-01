#!/bin/zsh

## I used this script to wrap the original tabler SVG icons in Astro components.
## You can find the original icons here: 
## 
## https://github.com/tabler/tabler-icons/tree/master/icons
## 
## I do NOT own any of the icons, all credit goes to Mr @codecalm


# Assume running from tabler-icons project directory
for FILE in $(ls icons); do
    # Space delimited array
    arr=($(echo "${FILE%.svg}" | tr "-" " "))
    
    # capitalized camelcase
    # some-icon-name -> SomeIconName
    capitalized=""    
    for NAMEPART in $arr; do
        NAMEPART="$(tr '[:lower:]' '[:upper:]' <<< ${NAMEPART:0:1})${NAMEPART:1}"
        capitalized=$capitalized${NAMEPART}
    done

    ASTRO_FILE="icons-astro/${capitalized}.astro"

    # Default astro values
    default_size="24"
    default_strokewidth="1.5"

    # Astro frontmatter
    echo -e "---\ntype Props = {\n    size?: number;\n    strokeWidth?: number;\n};\n\nconst { size = $default_size, strokeWidth = $default_strokewidth } = Astro.props;\n---\n" > $ASTRO_FILE

    # Substituted SVG
    cat icons/$FILE | \
        # size parameter in width
        sed -E 's/(<svg.*) width="[0-9]+"/\1 width=\{size\}/' | \
        # size parameter in height
        sed -E 's/(<svg.*) height="[0-9]+"/\1 height=\{size\}/' | \
        # strokeWidth parameter
        sed -E 's/(<svg.*) stroke-width="[0-9]+"/\1 stroke-width=\{strokeWidth\}/' >> $ASTRO_FILE

    echo Generated $capitalized ...

done