#!/bin/bash

jirac_select() {
	local PS3="${1} ? --> "
	cd $3
	select answer in $($2)
	do
	    if [[ -n $answer ]]; then
		cd - 2>&1 > /dev/null
		break
	    else
		echo "Invalid choice"
	    fi
	done
}
