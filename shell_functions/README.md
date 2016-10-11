Usage:
------------
Loading these functions into your shell, you can execute Gauntlt in a Docker container as if it were installed on your host OS.
One way of doing that is this:

1. Make sure your profile loads `$HOME/.bashrc`.  Depending on your operating system, that file could be one of a few:
- `$HOME/.bash_profile`
- `$HOME/.profile`
- etc

```
# cat $HOME/.bash_profile
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
```

2. In your `$HOME/.bashrc`, add this code to load all of the functions stored in your desired directory.
For example, to load all functions stored in `$HOME/.bash_functions`, include this in your `.bashrc`

```
# cat $HOME/.bashrc
if [[ -d $HOME/.bash_functions ]]; then
	for file in $HOME/.bash_functions/*; do
		. $file
	done
fi
```

3. Create the directory you're including in your `.bashrc`, copy the shell functions there and source your profile.

```
$ mkdir -p $HOME/.bash_functions
$ cp check_docker_perms.sh gauntlt.sh $HOME/.bash_functions
$ source $HOME/.bash_profile
```

4. Execute gauntlt!

```
$ gauntlt
gauntlt is a ruggedization framework that helps you be mean to your code

Usage:
       gauntlt <path>+ [--tags TAG_EXPRESSION] [--format FORMAT]

Options:
  -t, --tags=<s>      Only execute specified tags
  -l, --list          List defined attacks
  -s, --steps         List the gauntlt step definitions that can be used inside of attack files
  -a, --allsteps      List all available step definitions including aruba step definitions which help with file and parsing operations
  -f, --format=<s>    Available formats: html, json, junit, progress
  -v, --version       Print version and exit
  -h, --help          Show this message
```

Bash Completion Installation
-----------------
## Red Hat family
1. Install the file shell_functions/bash_completion/gauntlt.bash to /etc/bash_completion.d/
2. Start a new shell
