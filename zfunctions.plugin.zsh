# zfunctions
# Adds support for a functions directory to contain lazy-loaded zsh functions
0=${(%):-%N}

# get the config options
if zstyle -T ':zfunctions:*' 'path'; then
  zstyle ':zfunctions:*' 'path' ${ZDOTDIR:-$HOME/.config/zsh}/functions
fi
zstyle -s ':zfunctions:*' 'path' _zfuncdir

# load this projects functions
fpath=("${0:A:h}/functions" $fpath)
for _zfunc in "${0:A:h}/functions"/*(.N); do
  autoload -Uz "$_zfunc"
done

# load the zfunctions
[[ -d "$_zfuncdir" ]] || mkdir -p "$_zfuncdir"
fpath=("$_zfuncdir" $fpath)
for _zfunc in "$_zfuncdir"/*(.N); do
  autoload -Uz "$_zfunc"
done

# cleanup
unset _zfunc _zfuncdir
