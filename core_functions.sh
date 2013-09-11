#!/bin/bash

checkDependency() {
	command -v $1 >/dev/null 2>&1 || { echo >&2 "[ERROR] ${1} is required but is not installed.  Aborting."; exit 1;}
}

log() {
	if [ $1 = "ERROR" ]; then
		echo "[ERROR] $2";
	elif [ $1 = "INFO" ]; then 
		echo "[INFO] $2";
	elif [ $1 = "DEBUG" ]; then 
		echo "[DEBUG] $2";
	fi
}
