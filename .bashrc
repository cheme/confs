#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=~/.cabal/bin:~/bin:$PATH
export PATH=~/.gem/ruby/1.9.1/bin:$PATH
export EDITOR=vim
export VISUAL=vim
lesskey ~/.lesskeys
# archey
