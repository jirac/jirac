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

jirac_help() {
    echo -e "usage: jirac [-n number_of_commit]\nIf used with -n option the provided parameter must be a positive integer."
}

jirac_read_option() {
    while getopts ":n:" opt; do
        case $opt in
            n)
                if [ $OPTARG -gt 0 ]; then
                    echo "and it's positive"
                    number_of_commit=$OPTARG
                else
                    jirac_help
                    exit 1
                fi
                ;;
            \?)
                jirac_help
                exit 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                exit 1
                ;;
        esac
    done
}

jirac_banner_print() {
echo "
       _ _____ _____              _          _                 _ 
      | |_   _|  __ \     /\     | |        | |               | |
      | | | | | |__) |   /  \    | |__   ___| |_ __   ___ _ __| |
  _   | | | | |  _  /   / /\ \   | '_ \ / _ \ | '_ \ / _ \ '__| |
 | |__| |_| |_| | \ \  / ____ \  | | | |  __/ | |_) |  __/ |  |_|
  \____/|_____|_|  \_\/_/    \_\ |_| |_|\___|_| .__/ \___|_|  (_)
                                              | |                
                                              |_|                       
"
}

jirac_victorious_print(){
    jirac_two_fingers
}

jirac_two_fingers(){
    echo '
                            __
                           /  \
                          |    |
            _             |    |
          /" |            | _  |
         |   |            |    |
         | _ |            |    |
         |   |            |    |
         |   |        __  | _  |
         | _ |  __   /  \ |    |
         |   | /  \ |    ||    |
         |   ||    ||    ||    |       _---.
         |   ||    ||    |. __ |     ./     |
         | _. | -- || -- |    `|    /      //
         |"   |    ||    |     |   /`     (/
         |    |    ||    |     | ./       /
         |    |.--.||.--.|  __ |/       .|
         |  __|    ||    |-"            /
         |-"   \__/  \__/             .|
         |       _.-"                 /
         |   _.-"      /             |
         |            /             /
         |           |             /
         `           |            /
          \          |          /"
           |          `        /
            \                ."
            |                |
            |                |
            |                |
            |                |
    '
    echo "Paste it now \o/"
}

