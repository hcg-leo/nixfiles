# NixFiles

my NixOS dotfiles, essentially. These allow you to generate an approximate of my system or study them if
you want.


Overview

```
.
├── .config
│   ├── btop
│   │   ├── btop.conf
│   │   └── themes
│   │       └── mac.theme
│   ├── cava
│   │   ├── config
│   │   ├── shaders
│   │   │   ├── bar_spectrum.frag
│   │   │   ├── eye_of_phi.frag
│   │   │   ├── northern_lights.frag
│   │   │   ├── pass_through.vert
│   │   │   ├── spectrogram.frag
│   │   │   └── winamp_line_style_spectrum.frag
│   │   └── themes
│   │       ├── solarized_dark
│   │       └── tricolor
│   ├── fastfetch
│   │   └── config.jsonc
│   ├── foot
│   │   └── foot.ini
│   ├── mako
│   │   └── config
│   ├── nvim
│   │   ├── init.lua
│   │   └── lua
│   │       └── svim
│   │           ├── dashboard.lua
│   │           ├── defaults.lua
│   │           ├── git.lua
│   │           ├── init.lua
│   │           ├── lsp.lua
│   │           └── plugins.lua
│   ├── qutebrowser
│   │   ├── bookmarks
│   │   │   └── urls
│   │   ├── config.py
│   │   ├── greasemonkey
│   │   ├── newtab.html
│   │   ├── quickmarks
│   │   └── qute.svg
│   ├── swindle
│   │   ├── config.lua
│   │   └── walls
│   │       ├── 1.png
│   │       └── 2.jpg
│   ├── waybar
│   │   ├── config.jsonc
│   │   ├── style.css
│   │   └── waybar.css
│   └── wofi
│       └── style.css
├── LICENSE
├── .mkshrc
├── nixos
│   ├── configuration.nix
│   ├── flake.lock
│   ├── flake.nix
│   └── hardware-configuration.nix
└── README.md
```


# The files and what they configure

* `nixos/`: My NixOS configuration
* `.config/btop/`: My btop configuration
* `.config/cava/`: My cava configuration
* `.config/fastfetch/`: Legendary fastfetch configuration file
* `.config/mako/`: Notification daemon
* `.config/nvim/`: Personalised [svim](https://github.com/kantiankant/svim) configuration
* `.config/qutebrowser/`: Browser config
* `.config/swindle`: Compositor configuration
* `.config/waybar/`: Bar configuration
* `.config/wofi/`: App launcher configuration
* `.mkshrc`: mksh configuration

> note: to use my .mkshrc, you need [hgfast](https://gitea.hgdump.net/tsukasa/hgfast)



# LICENSE

Everything here is licensed under the GNU General Public License Version 3


