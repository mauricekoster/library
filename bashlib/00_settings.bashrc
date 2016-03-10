
#---------------
# Some settings
#---------------

ulimit -S -c 0		# Don't want any coredumps
set -o notify
set -o noclobber
set -o ignoreeof
#set -o nounset
#set -o xtrace          # useful for debuging

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob	# necessary for programmable completion

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Disable options:
shopt -u mailwarn
unset MAILCHECK		# I don't want my shell to warn me of incoming mail

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
