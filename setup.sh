#! /usr/bin/env bash

to_root=( bash_profile bashrc bashrc.d tmux.conf )
for f in "${to_root[@]}"; do
	ln -srf ${f} "${HOME}/.${f}"
done
unset to_root

ln -sfrt ${XDG_CONFIG_HOME:-"$HOME/.config"} alacritty fish ghostty nvim tmux-config
