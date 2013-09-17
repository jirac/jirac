# JIRAc: a comment helper

## Goal

Automate JIRA comment creation.
It will put the comment contents in your clipboard.

## Setup

 1. cd /path/to/projects
 1. git clone ... ;)
 1. $EDITOR ~/.bashrc # or ~/.zshrc
 1. export /path/to/projects/jirac in $PATH

You can now use `jirac` from anywhere.
Once launched, just answer a few questions.

## Why `jirac` only shows pushed commits

If some other new commits were pushed while you were working, you would have to pull those changes before pushing.
The problem occurs when rebase is enabled by default. What will happen then?

Well, as Git *NEVER* changes any commits, rebase will clone your commits, append them to the pulled changes and *assign them new IDs*!
Therefore, the early-generated commits' URLs are likely to be wrong as it will include old IDs (the ones before rebase).

## Troubleshooting

Ping `@fbiville`/`@Ismael` on Flowdock.
Create a Gitlab issue if needed.
