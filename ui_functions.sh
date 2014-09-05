#!/bin/bash

jirac_select() {
    local PS3="${1} ? --> "
    (cd $3
    select answer in $(eval "$2"); do
    if [ -n "$answer" ]; then
        echo $answer
    exit
    else
        message_and_exit "Invalid choice"
    fi
    done)
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
    echo "usage: jirac [-n number_of_commit] [--help] [--silent] [-grep regexp] [-l 0/1/2] [--standard-output]"
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
    echo "    --standard-output: generated comment is printed to stdout instead of the clipboard"
    echo "             - useful to pipe jirac generated comment to another command"
    echo "             - requires at least one of options --number and --grep to be set"
    echo "             - implicitly changes log level to 0 (only error logs)"
}
