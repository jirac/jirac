#!/bin/bash


checkDependency(){
command -v $1 >/dev/null 2>&1 || { echo >&2 "[ERROR] ${1} is required but is not installed.  Aborting."; exit 1;}
}

selectStatement(){
local PS3="${1} ? --> "
cd $3
select answer in $($2)
do
    if [[ -n $answer ]]
    then
        cd -
        break
    else
        echo "Invalid choice"
    fi
done
}

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

export project_hosted_name="fjdslfjdsl"
msg=$(cat template.md | grep h6)
echo $msg

echo -ne "# \033[7mDEPENDENCY CHECK...\033[m "
for dependency in git xclip mvn
do
    checkDependency $dependency
done

if [ ! -f ~/.jiracomments ]; then
	echo "config file ~/.jiracomments is missing. Aborting."
	exit 1
fi 

project_path=$(cat  ~/.jiracomments)
if [ ! -d $project_path ]; then
	echo "invalid config file: $project_path is not a directory. Aborting."
	exit 1
fi


echo " OK!"
echo "[INFO] Project root directory: $project_path"
echo 

echo -e "# \033[7mQUESTION TIME!\033[m"

# project folder
echo "Which maven project ?"
selectStatement Project ls $project_path
project=$answer
project_pom="$project_path/$project/pom.xml"
project_git_location="$project_path/$project/.git"


# Some basic verification. Fail early principe
if [ ! -f  $project_pom ]
then
	echo "[ERROR] No POM file found in the project directory. Aborting."
    exit 1
fi

if [ ! -d $project_git_location ]
then 
    echo "[ERROR] The provided directory is not a git repository. Aborting."
    exit 1

fi

# version

echo -n "## Grabbing Maven artifact version... "

if [ -f "$project_pom" ]
then 
	project_version=$(mvn help:evaluate -Dexpression=project.version -f $project_pom | grep '^[0-9].*')
fi

if [ -z "$project_version" ]; then
	echo "no version found!"
	echo "[ERROR] Either you don't follow a semantic versioning scheme or this is not a Maven project. Aborting."
	exit 1
else
	echo " OK!"
	echo "[INFO] version: $project_version"
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
echo "Which branch concern the modification ?"
echo $project_git_location
selectStatement Branch "git branch" $project_git_location
branch=$answer

# commits

while [ -z "$message" ] || [[ $REPLY =~ ^[Yy]$ ]]
do
	echo -e "## Which commit \033[1mSHA1\033[m?"
	echo -ne "\t"
	read sha1
	
	if [ -n "$sha1" ]
    then
		message=$(git --git-dir=$project_git_location log --format=%B $sha1 | head -n 1)

		if [ -n "$message" ]; then
			sha1s+=" "$sha1
			## FIXME: echo print \n instead of printing newline 
			messages+="\n"$message
		fi
	fi 

	read -p "Other SHA1s (y/n)? " -n 1 -r
	echo ""
done



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
	description=$default_description
fi

echo ""
echo -e "## \033[7mFINAL RESULT...\033[m"
echo "
h6. $project_hosted_name
 * Branch: $branch
 * Version: $project_version
 * Commit(s)"

for sha1 in $sha1s
do
    ## Warning, this line is valid only if the provided SHA is in the current branch FIXME
    complete_sha1=$(git --git-dir=$project_git_location log --format=raw | grep $sha1 | cut -d " " -f2)
	## TODO: check structure
	echo " ** http://gitlab.fullsix.net/$project_hosted_name/commits/$branch/$complete_sha1"
done

if [ -n description ]
then
	echo " * Description: $description"
fi


# interpolation template

# xclip du template interpolé (voir ci-dessous)
# commande : xclip -sel clip < my_template

# exemple template (fichier à part)
# h6. git_project_name
#
# * Branch: xx
# * Version: x.y.z
# * Commit(s):
#**   gitlab_link_1
#**   gitlab_link_2
#**   ...
#* description (si y'en a une): ... 
