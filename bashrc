# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export CDPATH=".:$HOME:$HOME/Projects${CDPATH:+:${CDPATH}}"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

if [ -z PROMPT_COMMAND ]; then declare -a PROMPT_COMMAND; fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
	if [ -d ~/.bashrc.d/optional ]; then
		for rc in ~/.bashrc.d/optional/*; do
			if [ -f "$rc" ]; then
				. "$rc"
			fi
		done
	fi
fi
unset rc

# CUDA toolkit PATH
if [ -z ${CUDA_PATH} ]; then
	export CUDA_PATH="/usr/local/cuda"
	export PATH="${CUDA_PATH}/bin:$PATH"
	export LD_LIBRARY_PATH="${CUDA_PATH}/lib64:$LD_LIBRARY_PATH"
fi

if which clang &> /dev/null; then
	export CC="$(which clang)"
	export CXX="$(which clang++)"
# Apply local settings and overrides
if [ -d ~/.bashrc.d/overrides/ ]; then
	for rc in ~/.bashrc.d/overrides/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
