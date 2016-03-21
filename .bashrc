#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=~/.cabal/bin:./.cabal-sandbox/bin:~/bin:$PATH
export PATH=~/.gem/ruby/1.9.1/bin:$PATH
export EDITOR=vim
export VISUAL=vim
# racer
export RUST_SRC_PATH=/home/emeric/work/rustc/rust/src
# archey
lesskey ~/.lesskeys
# no gtk (eclipse java swt)
SWT_GTK3=0

