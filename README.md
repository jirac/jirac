# JIRAc: comment helper

> // It's about comments, stupid!

## Goal

Automate JIRA comment creation from Git commits for a Maven project.

This command line tool will generate a formatted comment for JIRA right into your clipboard.

## Downloads

### Latest

git clone ;-)

## Common setup

Make to sure to:

 1. install Git (with Git Bash on Windows) 
 1. install XMLStarlet with this [link](http://xmlstar.sourceforge.net/download.php) or via your package manager
 1. clone this repo ;) and include the clone directory in `PATH`
 1. define environment variable `VISUAL` or `EDITOR` (e.g.: "vim")

### Linux users

Make sure to install 

 * `xclip` package

### Windows users

Make sure to install:

 * [mktemp](http://gnuwin32.sourceforge.net/packages/mktemp.htm) and include its `bin` folder in `PATH`

### Mac users

Make sure to install:

 * `pbcopy`


### Quick note on editor export

If you plan to export a graphical editor (such as gedit, Sublime Text etc), you should already know you **HAVE TO** specify specific options ("-w -s" for gedit, "-n -w" for Sublime) in the editor export so that it **BLOCKS** the calling script.

Obviously regardless of the editor you use, **escape spaces in its path before exporting it**!

## Execution

`jirac` must be executed from the root directory of a Maven project version controlled with Git. Otherwise an informative message will be displayed.

After selecting one or more commits, either interractively or with command line arguments, `jirac` will generate a formatted text for JIRA 
with the following information and copy it to your clipboard:
* name of the projet
* current branch
* current version
* for each selected commit
    - title
    - content
    - link the commit in the GIT graphical interface of the project (if any)

## Why `jirac` only shows pushed commits

If some other new commits were pushed while you were working, you would have to pull those changes before pushing.
The problem occurs when rebase is enabled by default. What will happen then?

Well, as Git *NEVER* changes any commits, rebase will clone your commits, append them to the pulled changes and *assign them new IDs*!
Therefore, the early-generated commits' URLs are likely to be wrong as it will include old IDs (the ones before rebase).

To remain on the safe side, `jirac` therefore enforces *pushed* commit selection.

## Manual

See [this](http://ihommani.gitbooks.io/jirac-guide/) doc.

## Troubleshooting

:fearful:

Create a [Github issue](https://github.com/jirac/jirac/issues) if needed with as much as details as you can.


