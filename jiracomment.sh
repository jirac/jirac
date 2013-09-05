#!/bin/bash

echo "JIRA comment helper"

echo "Checking prerequisites..."

command -v git >/dev/null 2>&1 || { echo >&2 "Git is required but it's not installed.  Aborting."; exit 1;}
command -v xclip >/dev/null 2>&1 || { echo >&2 "Xclip but it's not installed.  Aborting."; exit 1;}

if [ ! -f ~/.jiracomments ]; then
	echo "Config file ~/.jiracomments is missing. Aborting."
	exit 1
fi 

project_path=$(cat  ~/.jiracomments)
if [ ! -d $project_path ]; then
	echo "Invalid config file: $project_path is not a directory"
	exit 1
fi


echo "... OK!";

echo "Question time!"

# project folder

until [ ! -z $project ] && [ -d "$project_path/$project" ]; do
	echo "Which project (folder) ?"
	read project
done

# project name (default: project folder)

# branch

until [ ! -z $(git branch | grep $branch) ]; do
	echo "Which branch ?"
	read branch
done

# TODO: checkout branch
# utiliser mnv pour choper la version
# version : mvn help:evaluate -Dexpression=project.version -q ????? + grep pour virer les lignes de logs

echo $branch

# commits (sha1)?

# pour chaque commit (au moins 1)
#  - construire lien gitlab (project name + sha1)
#  - récupérer message commit (description += newline + 1ere ligne du msg de commit)
# continuer ? oui/non (y'a une cmd toute faite pour ça)

# override description (defaut: concatenation commits) : oui/non/pas de description
# sinon skip

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

