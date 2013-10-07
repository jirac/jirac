# JIRAc: comment helper

> // It's about comments, stupid!

## Goal

Automate JIRA comment creation.

It will insert the comment contents right into your clipboard.

## Common setup

Make to sure to:

 1. install Git (with Git Bash on Windows) 
 1. install XMLStarlet with this [link](http://xmlstar.sourceforge.net/download.php) or via your package manager
 1. clone this repo ;) and include the clone directory in `PATH`
 1. define environment variable `EDITOR` (e.g.: "vim")

### Linux users

Make sure to install 

 * `xclip` package

### Windows users

Make sure to install:

 * [mktemp](http://gnuwin32.sourceforge.net/packages/mktemp.htm) and include its `bin` folder in `PATH`

### Mac users

Make sure to install:

 * `pbcopy`


## Execution

You can now use `jirac` from anywhere or from a specific Git/MVN project.
Once launched, two things can happen:

 1. a few questions will be asked if the current directory does not belong to a MVN/GIT project file tree
 1. you will have to select the commits you want to display and decide to keep their description, overwrite it OR have no description at all

Then, your commit selection will be formatted as a nice informative comment and inserted into your clipboard.

## Why `jirac` only shows pushed commits

If some other new commits were pushed while you were working, you would have to pull those changes before pushing.
The problem occurs when rebase is enabled by default. What will happen then?

Well, as Git *NEVER* changes any commits, rebase will clone your commits, append them to the pulled changes and *assign them new IDs*!
Therefore, the early-generated commits' URLs are likely to be wrong as it will include old IDs (the ones before rebase).

To remain on the safe side, `jirac` therefore enforces *pushed* commit selection.

## Troubleshooting

Ping `@fbiville`/`@Ismael` on Flowdock.

Create a [Gitlab issue](https://gitlab.fullsix.com/sfr-sandbox/jira-comment/issues) if needed with as much as details as you can.
