#!/bin/bash

error(){
    echo "$@" >&2
    usage_and_exit 1
}

usage_and_exit(){
    jirac_help
    exit $1
}

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

jirac_verify_print_mode() {
    if [ "$print_mode" != "0" ] && [ "$print_mode" != "1" ]; then
        echo "Print mode value is invalid"
        jirac_help
        exit 1
    fi
}

jirac_help() {
    echo "usage: jirac [-n number_of_commit] [ -p print_mode ]"
    echo "    -n : shortcut to select the n last commits without interactively selecting them"
    echo "         parameter must be a positive integer"
    echo "    -p : select print_mode, supported value are "
    echo "         0 : original printing mode of JIRAC"
    echo "             - default print mode, used when option -p is not specified"
    echo "             - commits are listed in most-recent-first order"
    echo "             - commits links are displayed as items of a single first level list"
    echo "             - commits' bodies are appended into a desrciption which is displayed as a first level item"
    echo "             - this description can be override with an interactive prompt"
    echo "         1 : print mode based on commit subject and body"
    echo "             - commits are listed in oldest-first order"
    echo "             - each commit get its own first level sublist"
    echo "             - first level item of each commit is the subject of the commit"
    echo "             - second level items of each commit are : the link to the commit, the body of the commit"
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

