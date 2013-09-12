# JIRAc: a comment helper

## Goal

Automate JIRA comment creation.
It will put the comment contents in your clipboard.

## Setup

 1. git clone ... ;)
 1. cd /path/to/clone
 1. ./jirac

If you want to use `jirac` from anywhere, make sure to 
export `/path/to/clone` into your PATH (`~/.bashrc`, `~/.zshrc`...).

Once launched, just answer a few questions.

## How jirac allows you to choose commits

TL;DR: `jirac` allows you to comment only pushed commit.

Why?

If some other new commits were pushed while you were working, you would have to pull those changes before pushing.
The problem occurs when rebase is enabled by default. What will happen then?

Well, as Git *NEVER* changes any commits, rebase will clone your commits, append them to the pulled changes and *assign them new IDs*!
Therefore, the early-generated commits' URLs are likely to be wrong as it will include old IDs (the ones before rebase).

## Troubleshooting

Ping `@fbiville`/`@Ismael` on Flowdock.
Create a Gitlab issue if needed.
