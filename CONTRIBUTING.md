# How to contribute

All changes, including minor ones, have to be sent as pull requests.
Here is the quick guide on how to do it.

## Pull Request: step by step

 1. open a detailed issue describing the changes you plan to push
 1. [https://github.com/jirac/jirac/fork](fork) jirac
 1. `git clone` your fork
 1. `cd /path/to/your/fork; git checkout issue_X` where `X` is the issue number
 1. make your changes
 
## Note on commit format

Almost there. Before describing how to send your PR, please make sure your commit(s)
are formatted according to jirac guidelines, i.e.:

```
[#N] Short description of the change (less than 70 chars, tense: present)

[First long paragraph in tense present First long paragraph First long  
paragraph First long paragraph First long paragraph First long First long 
paragraph First long paragraph First long paragraph First long First long 
paragraph First long paragraph First long paragraph First long First long 
paragraph First long paragraph First long paragraph First long First long]
[

Second long paragraph...]
```

You opened, say, issue 42. Here a is well-formatted commit:

```
[#42] jirac now works on Gameboy

This change ports jirac in gameboy-shell and includes its specific
packaging as well.
```

## PR creation

You can push your changes to your fork.
