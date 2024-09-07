#set -q XDG_DATA_HOME;     or set -x XDG_DATA_HOME ~/.local/share
set -q XDG_CONFIG_HOME;   or set -x XDG_CONFIG_HOME ~/.config
set -q XDG_CACHE_HOME;    or set -x XDG_CACHE_HOME ~/.cache

set -q XDG_DESKTOP_DIR;   or set -x XDG_DESKTOP_DIR ~/Desktop
set -q XDG_DOWNLOAD_DIR;  or set -x XDG_DOWNLOAD_DIR ~/Downloads
set -q XDG_DOCUMENTS_DIR; or set -x XDG_DOCUMENTS_DIR ~/Documents
set -q XDG_PICTURES_DIR;  or set -x XDG_PICTURES_DIR ~/Pictures
set -q XDG_VIDEOS_DIR;    or set -x XDG_VIDEOS_DIR ~/Videos

#set -q XDG_CURRENT_DESKTOP; or set -x XDG_CURRENT_DESKTOP KDE

set -q EDITOR;            or set -x EDITOR nvim
set -q VISUAL;            or set -x VISUAL code
set -q BUN_INSTALL;       or set -x BUN_INSTALL ~/.bun

set -q GHCUP_INSTALL_BASE_PREFIX
or set -x GHCUP_INSTALL_BASE_PREFIX $HOME
