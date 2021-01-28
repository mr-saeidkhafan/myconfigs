#
# ~/.bashrc
#

# vi mode for bash
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-command 'v: ""'
bind '"jj":vi-movement-mode'

# git branch
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# set tmux as default shell
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# colors
CYAN=$(tput setaf 6)
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
LIME_YELLOW=$(tput setaf 4)
POWDER_BLUE=$(tput setaf 153)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

#PS1="\e[0;36m\u@\h\e[m (\W)\$(parse_git_branch)$ "
PS1='[\[${CYAN}\]\u\[${RED}\]@\[${NORMAL}\]\[${POWDER_BLUE}\]\h \[${NORMAL}\]\W]$(parse_git_branch)↯ '

# coloring stuffs
alias ls="ls --color=auto"
alias jn="jupyter notebook"
alias grep="grep --color=auto"
alias dir="dir --color=auto"
alias ip="ip -color=auto"
alias diff="diff --color=auto"
alias dmesg="dmesg --color=always"

# less config
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# custom alias
alias py=python
alias rm="rm -i"
alias pj="cd /home/core/mydir/projects/"
alias ll="ls -alhtrF --time-style=long-iso"
alias dl="cd /tmp/daily"
alias tk="tmux kill-session -t"
alias tka="tmux kill-session -a"
alias jc="jupyter-qtconsole"
alias showip="dig +short myip.opendns.com @resolver1.opendns.com"
alias vpnc="cd /home/core/mydir/confs/vpn/ && ./start.sh && cd -"
alias vpnd="cd /home/core/mydir/confs/vpn/ && ./reset.sh && cd -"

# path and python path
export PATH=$PATH:/home/core/.local/bin
export PATH=$PATH:/usr/lib/jvm/java-14-openjdk/bin/
export PYTHONPATH="/bin/python3.9"
export JAVA_HOME='/usr/lib/jvm/java-14-openjdk'

# bash completion
complete -cf sudo
