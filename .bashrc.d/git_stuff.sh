alias gst="git status"
alias gcmm="git commit -m"
alias gcma="git commit --amend"
alias glgg="git log --graph --abbrev"

PROMPT_COMMAND+=(\
'PROMPT_GIT_BRANCH=$(git branch --show-current 2>/dev/null);
PROMPT_GIT_BRANCH="${PROMPT_GIT_BRANCH:+$(set_ansi ${PROMPT_GIT_ICON_COLOR:-33})${PROMPT_GIT_COLOR:-${PROMPT_COLOR:+$(set_ansi ${PROMPT_COLOR@P})}${PROMPT_DIR_COLOR:+$(set_ansi ${PROMPT_DIR_COLOR@P})}}${PROMPT_GIT_BRANCH}}"'\
)
