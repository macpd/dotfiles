# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# helpful color codes
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\] [$?] \$ '
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CFh'

# preserve aliases when using sudo
#alias sudo='sudo '
alias raid='cd /media/raid'
alias software='cd /media/data/shared/Software'
alias music='cd /media/data/shared/Music'
export EDITOR="/usr/bin/vim"
alias vi="${EDITOR}"
# create necessary parent dirs and let me know
alias mkdir='mkdir -p -v'
function pgrep { ps uaxf | grep -v grep | grep "$@" -i  --color=auto ; }
# lists human-readable size of all directories in current dir
alias du1='sudo du -h --max-depth=1'
#alias openports='sudo netstat --all --numeric --programs --inet'
alias openports='sudo lsof -Pn | grep LISTEN'
alias ping='ping -c 4'
#display all processes running as root, effective UID and GID
alias rootprocs='ps u -U root -u root'
alias noir='ssh noir -p 21188'
# add google cloud storage util to path
export PATH="${PATH}:${HOME}/gsutil"


if [ -f /usr/bin/colordiff ] ; then
  alias diff='colordiff'
fi

# print pretty system info
if [ -f /usr/bin/archey ] ; then
  /usr/bin/archey
else 
  if [ -f ~/aperture-logo ] ; then
    echo -e ${txtcyn}
    cat ~/aperture-logo
    echo -e ${txtrst}
  fi
fi

# fucntion to reattch to screen, use session name if given
function reattach {
if [[ $# -ge 1 ]] ; then
  local SCREEN_SESSION_ARGS="-S $1"
fi

screen -rd $SCREEN_SESSION_ARGS
}

if [ -x .welcome_art ] ; then
  ./.welcome_art
fi
# see available screen sessions if not already in a screen session
if [ "${TERM}" != "screen" ] ; then
  screen -ls
fi

if [[ -z $SSH_AUTH_SOCK || ! -e $SSH_AUTH_SOCK ]] ; then
  eval $(ssh-agent)
fi

# add gsutil to path
export PATH=${PATH}:${HOME}/gsutil
