# functions.sh

function resource {
	. ${HOME}/.bashrc
}

function help () {
	builtin help $@ &> /dev/null
	if [ $? -eq 0 ]; then
		builtin help $@ | less
	else
		builtin help $@
	fi
}

function norminette ()
{
	if [ -z $1 ]; then
		command norminette $@
		return
	fi
	_usage () {
		echo "Wrapper function around norminette"
		echo "usage:"
		echo "norminette [-h] [-G] [args ...]"
		echo
		echo "options:"
		echo "	-h		Show this help"
		echo "	-G		Run norminette through grep"
		echo
		local user_input="";
		read -p "Show norminette help?(y): " user_input
		if [ ${user_input} = "y" ]; then
			command norminette -h
		fi
	}
	local unknown_opt=false show_usage=false use_grep=false
	local norm_opt OPTIND
	while getopts ":Gh" norm_opt $1; do
		case ${norm_opt} in
			h)
				show_usage=true
				;;
			G)
				use_grep=true
				;;
			\?)
				unknown_opt=true
				;;
		esac
	done
	if [ "${unknown_opt}" = true ]; then
		command norminette $@
		return
	elif [ "${show_usage}" = true ]; then
		_usage
		return
	elif [ "${use_grep}" = true ]; then
		shift
		command norminette $@ | grep -B1 -E "^Notice|^Error"
		return ${PIPESTATUS[0]}
	fi
	echo "Fallback reached" 1>&2
	command norminette $@
}
