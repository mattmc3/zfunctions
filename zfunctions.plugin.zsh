##? zfunctions - Use autoload functions directory for Zsh functions.

# Set $0.
0=${(%):-%N}

setopt extended_glob

# Use $ZFUNCDIR as functions directory.
: ${ZFUNCDIR:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/functions}
[[ -d $ZFUNCDIR ]] || mkdir -p $ZFUNCDIR

# Autoload Zsh function dir and its subdirs.
for _zfuncdir in ${0:a:h}/functions $ZFUNCDIR(N) $ZFUNCDIR/*(N/); do
  fpath=($_zfuncdir $fpath)
  _zautoloads=($_zfuncdir/*(N.:t))
  (( $#_zautoloads > 0 )) && autoload -Uz $_zautoloads
done
unset _zfuncdir _zautoloads
