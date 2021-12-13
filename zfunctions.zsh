# zfunctions
# Adds support for a functions directory to contain lazy-loaded zsh functions
0=${(%):-%N}

function autoload-dir() {
  ### lazy load all functions in a dir
  [[ -d "$1" ]] || return 1
  fpath=("$1" $fpath)
  local fn
  for fn in "$1"/*(.N); do
    autoload -Uz "$fn"
  done
}

# autoload this plugin's functions
autoload-dir "${0:A:h}/functions"
# autoload everything in $ZFUNCDIR
ZFUNCDIR="${ZFUNCDIR:-${ZDOTDIR:-$HOME/.config/zsh}/functions}"
autoload-dir "$ZFUNCDIR"
