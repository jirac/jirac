#!/bin/bash

jirac_get_git_project_root_directory() {
	echo $(git rev-parse --show-toplevel 2>&1 | grep -v "^fatal")
}

jirac_get_git_current_remote_branch() {
	local branch=$(git rev-parse --symbolic --abbrev-ref $(git symbolic-ref HEAD))
	echo $(git for-each-ref --format='%(refname:short):%(upstream:short)' refs/heads | grep "$branch:" | cut -d: -f2)
}

jirac_get_git_full_message() {
	echo -e "$(git --git-dir="$1" log --format=%B -n1 $2)"
}

jirac_list_git_commit() {
    echo  -e "$(git --git-dir="$1" log -10 --author="$2" --committer="$2" --format='%h %s' $3)"
}

jirac_keep_git_commit(){
    echo -e "$(git --git-dir="$1" log -"$2" --author="$3" --committer="$2" --format=%h $4)"
}
