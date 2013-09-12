#!/bin/bash


source ./core_functions.sh
source ./ui_functions.sh

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


echo -ne "# \033[7mDEPENDENCY CHECK...\033[m "
for dependency in git xclip mvn; do
    checkDependency $dependency
done

if [ ! -f ~/.jiracomments ]; then
	log ERROR "config file ~/.jiracomments is missing. Aborting."
	exit 1
fi 

project_path=$(cat  ~/.jiracomments)
if [ ! -d $project_path ]; then
	log ERROR "invalid config file: $project_path is not a directory. Aborting."
	exit 1
fi


echo " OK!"
log INFO "Project root directory: $project_path"
echo 

echo -e "# \033[7mQUESTION TIME!\033[m"

# project folder

echo "Which Maven project?"

selectStatement Project ls $project_path

project=$answer
project_pom="$project_path/$project/pom.xml"
project_git_location="$project_path/$project/.git"


# Some basic verification. Fail-fast principle
if [ ! -f  $project_pom ]; then
	log ERROR "No POM file found in the project directory. Aborting."
    exit 1
fi

if [ ! -d $project_git_location ]
then 
    log ERROR "The provided directory is not a git repository. Aborting."
    exit 1

fi


# version

echo -n "## Grabbing Maven artifact version... "

if [ -f "$project_pom" ]; then 
	project_version=$(mvn help:evaluate -Dexpression=project.version -f $project_pom | grep '^[0-9].*')
fi

if [ -z "$project_version" ]; then
	echo "no version found!"
	log ERROR "Either you don't follow a semantic versioning scheme or this is not a Maven project. Aborting."
	exit 1
else
	echo " OK!"
	log INFO "version: $project_version"
	echo ""
fi


# project hosted name (default: project folder)

read -p "## Override default project hosted name (y/n)? (current value: $project) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    while [ -z "$project_hosted_name" ]; do
	echo ""
	echo -ne "\t... which is? "
	read project_hosted_name
        echo ""
	done
else
	project_hosted_name=$project
fi


# branch

echo "On which branch are the modifications?"
echo $project_git_location
selectStatement Branch "git branch" $project_git_location
branch=$answer

# commits

author=$(git config user.name)
echo -e "## Which commit \033[1mSHA1s\033[m?"

while [[ -z ${short_hash} || $REPLY =~ ^[Yy]$ ]]; do
    temp_file=$(mktemp)
    echo "# Select a commit by prepending 'x ' (without quotes)" > $temp_file
    git --git-dir="${project_git_location}" log -10 --author="${author}" --format='%h %s' >> $temp_file
    $EDITOR $temp_file
    messages="$(grep '^x ' $temp_file)"
    for msg in "$messages"; do
	    short_hash+=$(echo $msg | cut -d " " -f2)
    done
    echo $short_hash

    echo $(echo ${default_description} | cut -d " " -f2-)
    read -p "Redo commit picking (y/n)? " -n 1 -r
    echo ""
done

temp_clip=$(mktemp)

# description override

default_description=$messages
read -p "## Override description (y/n/skip)? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
	while [ -z "$description" ]
    do
		echo -ne "\t... which is? "
		read description
	done
elif [[ $REPLY =~ ^[sS]$ ]]
then
	description=''
else
	description=$(echo ${default_description} | cut -d " " -f2)
fi

echo ""
echo -e "## \033[7mFINAL RESULT...\033[m"
echo "
*$project_hosted_name*
 * Branch: $branch
 * Version: $project_version
 * Commit(s)" >> $temp_clip
short_hashes=$(echo "${default_description}" | cut -d " " -f2) > /dev/null 2>&1 
for hash in $short_hashes; do
    complete_sha1=$(git --git-dir="$project_git_location" log --format="%H" $hash -1)
	echo " ** http://gitlab.fullsix.net/$project_hosted_name/commit/$branch/$complete_sha1" >> $temp_clip
done

if [ -n description ]
then
	echo -e " * Description:" >> $temp_clip
	echo "${default_description}" | cut -d " " -f2- >> $temp_clip
fi

    
xclip -sel clip < $temp_clip

echo "Stored in clipboard. Paste, paste, paste \o/"
