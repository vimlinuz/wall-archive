<div align="center">
<img src="./.github/assets/transparent.png" width="20%"/>
</div>

# Wallpaper Archive

This repository is a personal archive of beautiful wallpapers that I have gathered over time from a wide variety of sources and talented creators across the internet.
My aim is simply to make it easier for myself (and anyone who stumbles across this) to find inspiring desktop backgrounds that look great on all kinds of setups from minimal, modern desktops like Hyprland to classic window managers and everything in between.

## Wallpaper Previews

👉 [**Browse the full gallery**](https://vimlinuz.github.io/wall-archive/)

## How to use this

You need to put input into your flake.nix

```nix
#flake.nix
    inputs.wall-archive = {
      url = "github:vimlinuz/wall-archive";
      inputs.nixpkgs.follows = "nixpkgs";
    };
```

Then use this walls from inputs of the flake

```nix
{ pkgs, config, inputs, ... }:
let
  currentDesktop = builtins.getEnv "XDG_CURRENT_DESKTOP";
  theme = "${config.home.homeDirectory}/.config/rofi/themes/wallpaper-selector.rasi";
  WALLPAPER_DIR = "${inputs.wall-archive}/wallpapers";
in {
    # your script for setting up wallpapers
}
```

For script example you can look at mine: [script](https://github.com/vimlinuz/nixos/blob/main/homes/santosh/modules/scripts/rofi-wallpaper-selector.nix) \
Which currently uses rofi for picking wallpapers

The home-manager way if you want wallpapers into `$HOME` directory

```nix
{ inputs, ... }:
let
  wallpapers = "${inputs.wall-archive}/wallpapers";
in
{
  home.file = {
    "Pictures/wallpaper-archive" = {
      source = "${wallpapers}";
      recursive = true;
    };
  };
}
```

## License

This is a curated archive of wallpapers collected from various open sources and repositories.
All wallpapers belong to their original creators. This archive does not claim ownership of any content.
Please respect the original creators of the wallpapers. This collection is for personal use only.

> Usage: Personal use only. Do not redistribute or use for commercial purposes without permission from the original author.
> If you're a creator and would like your artwork removed or credited, please open an issue.
