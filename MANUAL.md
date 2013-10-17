# Manual

JIRAC(1)

**NAME**
> jirac - generates automatic JIRA comments and writes them to
clipboard.

**SYNOPSIS**
> **jirac** [OPTIONS]

**DESCRIPTION**
> **jirac** searches information from current Git/Maven project
> such as version, branch, project name and prompts pushed
> commits you authored for selection. Once commits are selected,
> the comment is ready to be pasted!
>
> 
> 
> In addition, **jirac** can be invoked outside a Git/Maven
> project and then prompts additional questions in order to
> resolve the project against which you want to work. This more
> interactive mode requires a configuration file
> **~/.jiracomments**.

**OPTIONS**
> **-n** number-of-commits
>
>   Skips the commit selection phase and select the last
>   number-of-commits authored by you.
>
> **-h** 
>   Displays help.

**NOTES**
:heart:
