let readme_template = "
# Wallpaper Archive

This repository is a personal archive of beautiful wallpapers that I have gathered over time from a wide variety of sources and talented creators across the internet.
My aim is simply to make it easier for myself (and anyone who stumbles across this) to find inspiring desktop backgrounds that look great on all kinds of setups from minimal, modern desktops like Hyprland to classic window managers and everything in between.

## Wallpaper Previews
### Static Wallpapers

<p align=\"center\">
"

# Get all files in wallpaper/ with image extensions, sorted
let images = ls wallpaper | sort-by name

let img_tags = $images | each {|it| 
    $"<img src=\"wallpaper/($it.name | path basename)\" width=\"300\">"
} | str join "\n"

let dynamic_note = "
</p>

---

## License

This is a curated archive of wallpapers collected from various open sources and repositories.
All wallpapers belong to their original creators. This archive does not claim ownership of any content.
Please respect the original creators of the wallpapers. This collection is for personal use only.

> Usage: Personal use only. Do not redistribute or use for commercial purposes without permission from the original author.
> If you're a creator and would like your artwork removed or credited, please open an issue.  
"

# Concatenate all parts and write to README.md
let final_readme = $readme_template + "\n" + $img_tags + "\n" + $dynamic_note
echo $final_readme | save -f README.md

echo $"README.md generated with ($images | length) static wallpapers."
