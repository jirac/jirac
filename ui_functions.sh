#!/bin/bash

error(){
    echo "$@" >&2
    usage_and_exit 1
}

model_error(){
    echo "$@" >&2
    exit 1
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

jirac_apply_print_mode() {
    case $1 in 
        "0" | "1" | 0 | 1 )
            print_mode=$1 
            ;;
        * )
        error "Print mode value is invalid"
        ;;
    esac
}

jirac_help() {
    echo "usage: jirac [-n number_of_commit] [ -p print_mode ] [--help] [--silent]"
    echo "    --number, -n : shortcut to select the n last pushed commits without interactively selecting them"
    echo "         parameter must be a positive integer"
    echo "         "
    echo "    --help, -h: Display this help"
    echo "         "
    echo "    --silent, -s: Run jirac on silent mode. I.e no more fancy helper prints"
    echo "         "
    echo "    --print-mode, -p: select print_mode, supported value are "
    echo "         "
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

