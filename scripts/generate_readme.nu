let readme_template = "
# Wallpaper Archive

This repository is a personal archive of beautiful wallpapers that I have gathered over time from a wide variety of sources and talented creators across the internet.
My aim is simply to make it easier for myself (and anyone who stumbles across this) to find inspiring desktop backgrounds that look great on all kinds of setups from minimal, modern desktops like Hyprland to classic window managers and everything in between.

## Wallpaper Previews
### Static Wallpapers
";

ls wallpapers/ | each { |file|
    let name = $file.name
    let new_name = $name
        | str replace -ar '[^a-zA-Z0-9_./]' '_'  # replace special chars with _
        | str replace -ar '_+' '_'                 # collapse multiple underscores
        | str downcase                             # lowercase everything
    if $name != $new_name {
        mv $name $new_name
    }
}

# Get all files in wallpapers/ with image extensions, sorted
let images = ls wallpapers | sort-by name

# let base_url = "https://raw.githubusercontent.com/vimlinuz/wall-archive/refs/heads/main"
let first_row = "
|          |          |          |          |
|----------|----------|----------|----------|
";

let rows = (
    $images
    | each {|it| $it.name | path basename }
    | chunks 4
    | each {|row|
        $row
        | each {|name|
            let url = $"wallpapers/($name)"
            $"![($name)]\(($url)\)"
        }
        | str join " | "
        | $"| ($in) |"
    }
| str join "\n"
);


let dynamic_note = "

---

## License

This is a curated archive of wallpapers collected from various open sources and repositories.
All wallpapers belong to their original creators. This archive does not claim ownership of any content.
Please respect the original creators of the wallpapers. This collection is for personal use only.

> Usage: Personal use only. Do not redistribute or use for commercial purposes without permission from the original author.
> If you're a creator and would like your artwork removed or credited, please open an issue.  
";

# Concatenate all parts and write to README.md
let final_readme = $readme_template + "\n" + $first_row +  $rows + "\n" + $dynamic_note;
echo $final_readme | save -f README.md

echo $"README.md generated with ($images | length) static wallpapers."
