#!/bin/sh

## live-build(7) - System Build Scripts
## Copyright (C) 2006-2012 Daniel Baumann <daniel@debian.org>
##
## live-build comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
## This is free software, and you are welcome to redistribute it
## under certain conditions; see COPYING for details.


Echo ()
{
	STRING="${1}"
	shift

	if [ "${_L10N}" = "true" ]
	then
		printf "$(eval_gettext "${STRING}")" "${@}"; echo;
	else
		printf "${STRING}\n" "${@}"
	fi
}

Echo_debug ()
{
	if [ "${_DEBUG}" = "true" ]
	then
		STRING="${1}"
		shift

		if [ "${_L10N}" = "true" ]
		then
			printf "D: $(eval_gettext "${STRING}")" "${@}"; echo;
		else
			printf "D: ${STRING}\n" "${@}"
		fi
	fi
}

Echo_debug_running ()
{
	if [ "${_DEBUG}" = "true" ]
	then
		STRING="${1}"
		shift

		if [ "${_L10N}" = "true" ]
		then
			printf "D: $(eval_gettext "${STRING}")" "${@}"
		else
			printf "D: ${STRING}" "${@}"
		fi

		if [ "${_COLOR}" = "false" ]
		then
			printf "..."
		else
			printf "... ${YELLOW}${BLINK}running${NO_COLOR}"
		fi
	fi
}

Echo_error ()
{
	STRING="${1}"
	shift

	if [ "${_COLOR}" = "false" ]
	then
		printf "E:"
	else
		printf "${RED}E${NO_COLOR}:"
	fi

	if [ "${_L10N}" = "true" ]
	then
		(printf " $(eval_gettext "${STRING}")" "${@}"; echo;) >&2
	else
		printf " ${STRING}\n" "${@}" >&2
	fi
}

Echo_message ()
{
	if [ "${_QUIET}" != "true" ]
	then
		STRING="${1}"
		shift

		if [ "${_COLOR}" = "false" ]
		then
			printf "P:"
		else
			printf "${WHITE}P${NO_COLOR}:"
		fi

		if [ "${_L10N}" = "true" ]
		then
			printf " $(eval_gettext "${STRING}")" "${@}"; echo;
		else
			printf " ${STRING}\n" "${@}"
		fi
	fi
}

Echo_message_running ()
{
	if [ "${_QUIET}" != "true" ]
	then
		STRING="${1}"
		shift

		if [ "${_COLOR}" = "false" ]
		then
			printf "P:"
		else
			printf "${WHITE}P${NO_COLOR}:"
		fi

		if [ "${_L10N}" = "true" ]
		then
			printf " $(eval_gettext "${STRING}")" "${@}";
		else
			printf " ${STRING}" "${@}"
		fi

		if [ "${_COLOR}" = "true" ]
		then
			printf "... ${YELLOW}${BLINK}running${NO_COLOR}"
		else
			printf "..."
		fi
	fi
}

Echo_verbose ()
{
	if [ "${_VERBOSE}" = "true" ]
	then
		STRING="${1}"
		shift

		if [ "${_L10N}" = "true" ]
		then
			printf "I: $(eval_gettext "${STRING}")" "${@}"; echo;
		else
			printf "I: ${STRING}\n" "${@}"
		fi
	fi
}

Echo_verbose_running ()
{
	if [ "${_VERBOSE}" != "true" ]
	then
		STRING="${1}"
		shift

		if [ "${_L10N}" = "true" ]
		then
			printf "I: $(eval_gettext "${STRING}")" "${@}";
		else
			printf "I: ${STRING}" "${@}"
		fi

		if [ "${_COLOR}" = "true" ]
		then
			printf "... ${YELLOW}${BLINK}running${NO_COLOR}"
		else
			printf "..."
		fi
	fi
}

Echo_warning ()
{
	STRING="${1}"
	shift

	if [ "${_COLOR}" = "false" ]
	then
		printf "W:"
	else
		printf "${YELLOW}W${NO_COLOR}:"
	fi

	if [ "${_L10N}" = "true" ]
	then
		printf " $(eval_gettext "${STRING}")" "${@}"; echo;
	else
		printf " ${STRING}\n" "${@}"
	fi
}

Echo_status ()
{
	__RETURN="${?}"

	if [ "${_COLOR}" = "false" ]
	then
		if [ "${__RETURN}" = "0" ]
		then
			printf " done.\n"
		else
			printf " failed.\n"
		fi
	else
		Cursor_columns_backward 8

		if [ "${__RETURN}" = "0" ]
		then
			printf " ${GREEN}done${NO_COLOR}.  \n"
		else
			printf " ${RED}failed${NO_COLOR}.\n"
		fi
	fi
}

Echo_done ()
{
	if [ "${_COLOR}" = "false" ]
	then
		printf " already done.\n"
	else
		Cursor_columns_backward 8

		printf " ${GREEN}already done${NO_COLOR}.\n"
	fi
}

Echo_file ()
{
	while read LINE
	do
		echo "${1}: ${LINE}"
	done < "${1}"
}

Echo_breakage ()
{
	case "${LB_DISTRIBUTION}" in
		sid|unstable)
			Echo_message "If the following stage fails, the most likely cause of the problem is with your mirror configuration, a caching proxy or the sid distribution."
			;;
		*)
			Echo_message "If the following stage fails, the most likely cause of the problem is with your mirror configuration or a caching proxy."
			;;
	esac

	Echo_message "${@}"
}
