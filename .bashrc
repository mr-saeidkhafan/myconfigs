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

PS1="🔺\t \u@\h (\W)\$(parse_git_branch)$ "

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
alias pj="cd ~/mydir/projects/"
alias ll="ls -alhtrF --time-style=long-iso"
alias dl="cd /tmp/daily"
alias tk="tmux kill-session -t"
alias tka="tmux kill-session -a"
alias jc="jupyter-qtconsole"
alias showip="dig +short myip.opendns.com @resolver1.opendns.com"
alias vpnc="cd /home/core/mydir/confs/vpn/ && ./start.sh && cd -"
alias vpnd="cd /home/core/mydir/confs/vpn/ && ./reset.sh && cd -"
# tensorflow shutup
alias tfs="echo 'import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import tensorflow as tf'"
# path and python path
export PATH=$PATH:/home/core/.local/bin
export PATH=$PATH:/usr/lib/jvm/default/bin
export PYTHONPATH="/bin/python3.8"
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'
export ANDROID_HOME="/home/core/.buildozer/android/platform/android-sdk"
export ANDROID_SDK="/home/core/.buildozer/android/platform/android-sdk"
export ANDROIDNDK="/home/core/.buildozer/android/platform/android-ndk-r19c"
export ANDROIDAPI="27"  # Target API version of your application
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bash completion
complete -cf sudo

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
