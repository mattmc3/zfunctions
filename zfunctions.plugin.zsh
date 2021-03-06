# zfunctions
# Adds support for a functions directory to contain lazy-loaded zsh functions
0=${(%):-%N}

zstyle -s ':zfunctions:*' 'path' _zfuncdir ||
  _zfuncdir=${ZDOTDIR:-$HOME/.config/zsh}/functions

function autoload_funcdir() {
  ### lazy load functions dir
  local funcdir="$1"
  [[ -z "$funcdir" ]] && echo "expecting function dir argument" >&2 && return 1
  [[ ! -d "$funcdir" ]] && echo "function dir not found: $funcdir" >&2 && return 1

  fpath=("$funcdir" $fpath)
  local fn
  for fn in "$funcdir"/*(.N); do
    autoload -Uz "$fn"
  done
}

# load this project's functions
autoload_funcdir "${0:A:h}/functions"

# load the zfunctions dir
autoload_funcdir "$_zfuncdir"

# cleanup
unset _zfuncdir
