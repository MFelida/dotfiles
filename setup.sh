#! /usr/bin/env bash
set -e

CWD=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
for f in {bash_profile,bashrc,bashrc.d,tmux.conf}; do
	ln -sf "$CWD/${f}" "${HOME}/.${f}"
done

for d in .config/*; do
	ln -sfT "${CWD}/${d}" "$HOME/${d}"
done
