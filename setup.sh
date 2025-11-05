#! /usr/bin/env bash

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
for f in {bash_profile,bashrc,bashrc.d,tmux.conf}; do
	ln -sf $CWD/${f} "${HOME}/.${f}"
done

for d in {alacritty,fish,ghostty,nvim,tmux-config}; do
	ln -sf ${CWD}/${d} ${XDG_CONFIG_HOME:-"$HOME/.config"}
done
