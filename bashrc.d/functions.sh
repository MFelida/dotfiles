# functions.sh

function help () {
	builtin help $@ &> /dev/null
	if [ $? -eq 0 ]; then
		builtin help $@ | less
	else
		builtin help $@
	fi
}

