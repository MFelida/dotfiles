#! /usr/bin/env bash

ln -sft ${HOME} .bash_profile .bashrc .bashrc.d .tmux.conf

ln -sft ${XDG_CONFIG_HOME:-"$HOME/.config"} alacritty fish nvim tmux-config

