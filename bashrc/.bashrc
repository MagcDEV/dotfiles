#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$HOME/.dotnet/tools:$PATH"

export TZ="America/Argentina/Buenos_Aires"
export MANPAGER='nvim +Man!'

eval "$(zoxide init bash)"

fastfetch
