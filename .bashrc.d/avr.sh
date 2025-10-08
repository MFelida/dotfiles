# avr.sh

avr_init_env() {
	C_INCLUDE_PATH="/usr/avr/include/${C_INCLUDE_PATH:+:${C_INCLUDE_PATH}}"
	LIBRARY_PATH="/usr/avr/lib/${LIBRARY_PATH:+:${LIBRARY_PATH}}"
}

avr_project () {
	local TEMPLATE_SRC="${HOME}/Templates/avr_project"
	if [ -z $1 ]; then
		2>& echo "${FUNCNAME}: provide dirname"
		return 1;
	fi
	mkdir -p "$1";
	if [ $? -ne 0 ]; then
		return 1;
	fi
	cp -rt "$1" "${TEMPLATE_SRC}"/*
}
