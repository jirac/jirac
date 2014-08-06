#!/bin/bash

jirac_select() {
    local PS3="${1} ? --> "
    cd $3
    select answer in $($2)
    do
        if [ -n $answer ]; then
            cd - 2>&1 > /dev/null
            break
        else
            message_and_exit "Invalid choice"
        fi
    done
}

jirac_apply_print_mode() {
    case $1 in
        "0" | "1" | 0 | 1 )
            print_mode=$1
            ;;
        * )
            message_and_exit "Print mode value is invalid"
            ;;
    esac
}

##
# put all options consistency verifications here
##
jirac_verify_options() {
    # when ouput-mode is "o", options --number or --grep must be specified
    if [[ "$output_mode" = "o" && -z "$number_of_commit" && -z "$regexp" ]]; then
        message_and_exit "Option --standard-output requires at least one of option --number or --grep to be set"
    fi
}

jirac_apply_log_level() {
    case $1 in
        "0" | "1" | "2" | 0 | 1 | 2 )
            log_level=$1
            ;;
        * )
        message_and_exit "Log level value is invalid"
        ;;
    esac
}

jirac_help() {
    echo "usage: jirac [-n number_of_commit] [ -p print_mode ] [--help] [--silent] [-grep regexp] [-l 0/1/2] [--standard-output]"
    echo "    --number, -n : shortcut to select the n last pushed commits without interactively selecting them"
    echo "         parameter must be a positive integer"
    echo "         "
    echo "    --help, -h: Display this help"
    echo "         "
    echo "    --silent, -s: Run jirac on silent mode, ie. no log to the console at all"
    echo "         "
    echo "    --log-level, -l: Sets the level of details of JIRAC logs to the console"
    echo "         0 : only error logs"
    echo "         1 : error and info logs"
    echo "         2 : error, info and debug logs"
    echo "         "
    echo "    --grep, -g: shortcut to select commits whose short description match the provided regexp"
    echo "         "
    echo "    --print-mode, -p: select print_mode, supported values are "
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
    echo "         "
    echo "    --standard-output: generated comment is printed to stdout instead of the clipboard"
    echo "             - useful to pipe jirac generated comment to another command"
    echo "             - requires at least one of options --number and --grep to be set"
    echo "             - implicitly enables silence mode (option --silent)"
}
