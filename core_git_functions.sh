#!/bin/bash

jirac_get_git_project_root_directory() {
    	if [ -d .git ]; then
		echo $(git rev-parse --show-toplevel)
    	fi
}

jirac_get_git_current_remote_branch() {
	local branch=$(git rev-parse --symbolic --abbrev-ref $(git symbolic-ref HEAD))
    	echo $(git for-each-ref --format='%(refname:short):%(upstream:short)' refs/heads | grep "$branch:" | cut -d: -f2)
}
