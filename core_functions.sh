#!/bin/bash

jirac_check_dependency() {
	command -v $1 >/dev/null 2>&1 || { echo >&2 log ERROR "${1} is required but is not installed.  Aborting."; exit 1;}
}

jirac_log() {
	if [ $1 = "ERROR" ]; then
		echo "[ERROR] $2";
	elif [ $1 = "INFO" ]; then 
		echo "[INFO] $2";
	elif [ $1 = "DEBUG" ]; then 
		echo "[DEBUG] $2";
	fi
}

jirac_get_maven_version() {
	echo $(__jirac_parse_maven_expression project.version $1 | grep '^[0-9].*')
}

jirac_get_maven_project_name() {
	echo $(__jirac_parse_maven_expression project.name $1 |  grep -v '\[')
}

jirac_get_scm_url() {
	echo $(__jirac_parse_maven_expression project.scm.connection $1 | grep '^scm' | cut -d':' -f3- | sed -s 's/\.git//')
}

jirac_get_git_project_root_directory() {
	echo $(git rev-parse --show-toplevel)
}

jirac_get_git_current_branch() {
	echo $(git rev-parse --symbolic --abbrev-ref $(git symbolic-ref HEAD))
}


__jirac_parse_maven_expression() {
	mvn help:evaluate -Dexpression=$1 -f $2
}
