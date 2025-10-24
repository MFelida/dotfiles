# prompt_setup.sh


declare -Fp set_ansi &> /dev/null
if [ $? -ne 0 ]; then
	set_ansi () {
		echo -n "\[\e[${1}m\]"
	}
fi

PROMPT_DIRTRIM=3

PROMPT_SEPARATOR=':'
PROMPT_START=""
PROMPT_HIGHLIGHT=""
PROMPT_USERHOST="\u@\h"
PROMPT_DIRECTORY="\w"
PROMPT_END="$(set_ansi 0)"

PROMPT_COLOR="32"
PROMPT_DIR_COLOR="32"
PROMPT_SEPARATOR_COLOR="97"
PROMPT_ERROR_COLOR="30;41"
PROMPT_GIT_COLOR="33"

PROMPT_END_DEFAULT=${PROMPT_END}

# Display exit code if error
_set_prompt_error () {
	function _is_signal () {
		if [[ ${1} -gt 128 ]] && [[ $((128 + ${#PROMPT_SIGNAL_STRINGS[@]})) -gt ${1} ]]; then
			return 0
		else
			return 1
		fi
	}
	local -a PROMPT_SIGNAL_STRINGS=("OOPSIE" "SIGHUP" "SIGINT" "SIGQUIT" "SIGILL"\
		"SIGTRAP" "SIGABRT" "SIGIOT" "SIGBUS" "SIGFPE" "SIGKILL" "SIGUSR1"\
		"SIGSEGV" "SIGUSR2" "SIGPIPE" "SIGALRM" "SIGTERM" "SIGSTKFLT"\
		"SIGCHLD" "SIGCONT" "SIGSTOP" "SIGTSTP" "SIGTTIN" "SIGTTOU" "SIGURG"\
		"SIGXCPU" "SIGXFSZ" "SIGVTALRM" "SIGPROF" "SIGWINCH" "SIGIO"\
		"SIGPWR" "SIGSYS" "SIGUNUSED")
	local RET
	RET=${1}
	if [ ${RET} -eq 0 ]; then
		PROMPT_END=${PROMPT_END_DEFAULT};
	elif _is_signal ${RET}; then
		RET=$((${RET} - 128))
		PROMPT_END=" ${PROMPT_ERROR_COLOR:+$(set_ansi ${PROMPT_ERROR_COLOR})}[${PROMPT_SIGNAL_STRINGS[${RET}]}]$(set_ansi 0)";
	else
		PROMPT_END=" ${PROMPT_ERROR_COLOR:+$(set_ansi ${PROMPT_ERROR_COLOR})}[${RET}]$(set_ansi 0)";
	fi
}
PROMPT_COMMAND+=('_set_prompt_error ${?}')

# Display git branch
update_git_branch () {
	if git rev-parse -is-inside-work-tree &> /dev/null; then
		PROMPT_GIT_BRANCH=$(git branch --show-current 2> /dev/null)
		if [ ${#PROMPT_GIT_BRANCH} -gt 19 ]; then
			PROMPT_GIT_BRANCH="${PROMPT_GIT_BRANCH:0:17}...";
		else
			PROMPT_GIT_BRANCH="${PROMPT_GIT_BRANCH}";
		fi
	else
		PROMPT_GIT_BRANCH=""
	fi
	PROMPT_GIT_BRANCH="${PROMPT_GIT_BRANCH:+$(set_ansi 0)\
${PROMPT_COLOR:+$(set_ansi ${PROMPT_COLOR@P})}\
${PROMPT_GIT_COLOR:+$(set_ansi ${PROMPT_GIT_COLOR@P})}\
${PROMPT_GIT_BRANCH@P}\
${NERD_FONT_ENABLED+$(set_ansi ${PROMPT_GIT_ICON_COLOR:-33})$(set_ansi 0)}\
}"
}
PROMPT_COMMAND+=('update_git_branch;')

PS1='${PROMPT_START@P}\[\e[0m\]${PROMPT_HIGHLIGHT:+\[\e[${PROMPT_HIGHLIGHT}m\]}${PROMPT_COLOR:+\[\e[${PROMPT_COLOR}m\]}${PROMPT_CONTAINER}${PROMPT_USERHOST:+${PROMPT_USERHOST@P}${PROMPT_SEPARATOR:+\[\e[0m\]${PROMPT_SEPARATOR_COLOR:+\[\e[${PROMPT_SEPARATOR_COLOR}m\]}${PROMPT_SEPARATOR@P}${PROMPT_SEPARATOR_COLOR:+\[\e[0m\]}${PROMPT_HIGHLIGHT:+\[\e[${PROMPT_HIGHLIGHT}m\]}${PROMPT_COLOR:+\[\e[${PROMPT_COLOR}m\]}}}${PROMPT_DIR_COLOR:+\[\e[${PROMPT_DIR_COLOR}m\]}${PROMPT_DIRECTORY@P}${PROMPT_GIT_BRANCH:+${PROMPT_SEPARATOR:+\[\e[0m\]${PROMPT_SEPARATOR_COLOR:+\[\e[${PROMPT_SEPARATOR_COLOR}m\]}${PROMPT_SEPARATOR@P}${PROMPT_SEPARATOR_COLOR:+\[\e[0m\]}${PROMPT_HIGHLIGHT:+\[\e[${PROMPT_HIGHLIGHT}m\]}${PROMPT_OLOR:+\[\e[${PROMPT_COLOR}m\]}${PROMPT_DIR_COLOR:+\[\e[${PROMPT_DIR_COLOR}m\]}}${PROMPT_GIT_COLOR:+\[\e[${PROMPT_GIT_COLOR}m\]}${PROMPT_GIT_BRANCH@P}}\[\e[1m\]${PROMPT_END@P}\$${PROMPT_END:+\[\e[0m\]} '

