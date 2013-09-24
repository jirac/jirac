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
    echo '
    +88_________________+880______
    _+880_______________++80______
    _++88______________+880_______
    _++88_____________++88________
    __+880___________++88_________
    __+888_________++880__________
    __++880_______++880___________
    __++888_____+++880____________
    __++8888__+++8880++88_________
    __+++8888+++8880++8888________
    ___++888++8888+++888888+80____
    ___++88++8888++8888888++888___
    ___++++++888888fx88888888888__
    ____++++++88888888888888888___
    ____++++++++000888888888888___
    _____+++++++00008f8888888888__
    ______+++++++00088888888888___
    _______+++++++0888f8888888____
    '
    echo "Paste it now \o/"
}
