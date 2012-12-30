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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

alias software='cd /media/data/shared/Software'
alias music='cd /media/data/shared/Music'
export EDITOR="/usr/bin/vim"
alias vi="${EDITOR}"
alias mkdir='mkdir -p -v'
# lists human-readable size of all directories in current dir
alias du1='sudo du -h --max-depth=1'
#alias openports='sudo netstat --all --numeric --programs --inet'
alias openports='sudo lsof -Pn | grep LISTEN'
alias diff='colordiff'

# function to tweet specified message ($1)
function tnotify { twidge dmsend mountainmanduke "$1 $(date +%l:%M%p)" ; }
alias ping='ping -c 4'
#display all processes running as root, effective UID and GID
alias rootprocs='ps u -U root -u root'
alias raid='cd /media/raid'
export PATH="${PATH}:${HOME}/gsutil"

# echo arguments, ask for confirmation to excute them
function echoConfirmExecute
{
	if [[ $# -eq '0' ]] ; then
		return 1
	fi

	# echo arguments and print prompt
	echo -n "$@ [Y|n]: "
#	local confirm="y"
	read confirm
	case "$confirm" in
		y|Y|"")
			$@
			;;
		*)
			echo "Aborted"
			return 2
			;;
	esac
	return $?
}
# offer to reconnect screen on ssh session
#if [ "$SSH_CLIENT" ] && [ "$TERM" != "screen" ] ; then
#	echoConfirmExecute "screen -r"
#fi
#if [ -f tux.txt ] ; then
#	cat tux.txt
#fi
