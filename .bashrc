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

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

PROMPT_END_DEFAULT=${PROMPT_END}

PROMPT_COMMAND+=(\
	'RET=$?
	if [ $RET -ne 0 ]; then
		PROMPT_END=" $(set_ansi ${PROMPT_ERROR_COLOR:-31})[$RET]$(set_ansi 0)";
	else
		PROMPT_END=${PROMPT_END_DEFAULT@P};
	fi
	unset RET')

