#!/usr/bin/env bash

set -euo pipefail

GREEN="\033[0;32m"
RESET="\033[0m"

wallpapers=$(ls wallpapers)

for wall in $wallpapers; do
    [[ -f "$wall" ]] ||   continue

    new_name=$(printf '%s' "$wall" \
            | sed -E '
                s/[^a-zA-Z0-9_./]/_/g
                s/_+/_/g
            ' \
            | tr '[:upper:]' '[:lower:]')

    if  [[ "$wall" != "$new_name" ]]; then
        mv "$wall" "./wallpapers/$new_name"
        echo "rename: $wall -> $new_name"
    fi
done

printf '%s\n' wallpapers/* \
| jq -R . \
| jq -s '{files: .}' > ./docs/generated.json


echo -e "${GREEN} Generated json successfull in ./docs/generated.json. ${RESET}"
