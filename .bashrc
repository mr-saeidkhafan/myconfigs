#
# ~/.bashrc
#

# vi mode for bash
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-command 'v: ""'
bind '"jj":vi-movement-mode'

# set tmux as default shell
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# git branch
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# coloring stuffs
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias dir="dir --color=auto"
alias ip="ip -color=auto"
alias diff="diff --color=auto"
alias dmesg="dmesg --color=always"
export TERM=screen-256color

# less config
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline



PS1="🔸\t $(if [[ ${EUID} == 0 ]]; then echo '\h'; else echo '\u' ;fi)\[\e[36m\]\$(parse_git_branch)\[\e[00m\]\[\033[01;36m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;36m\] \")\\$\[\033[00m\] "

# custom alias
alias py=python
alias pj="cd ~/mydir/projects/"
alias cmatrix="cmatrix -u 7"
alias ll="ls -alhtrF --time-style=long-iso"
alias dl="cd /tmp/daily"
alias tk="tmux kill-session -t"
alias tka="tmux kill-session -a"

# path and python path
export PYTHONPATH="/home/core/.local/bin/python3.8"
export PATH=$PATH:/home/core/.local/bin
export PATH=$PATH:/core/java/jre1.6.0_24/bin/
export PATH=$PATH:/home/core/.gem/ruby/2.7.0/bin
export PATH=$PATH:/root/.gem/ruby/2.7.0/bin

# bash completion
complete -cf sudo

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
