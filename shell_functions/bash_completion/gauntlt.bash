# bash completion for Gauntlt
# Author: Jeremy Young
# Asurion 10/10/2016

_gauntlt_completion () {
  local CUR=${COMP_WORDS[COMP_CWORD]}
  local PREV=${COMP_WORDS[COMP_CWORD-1]}
  local OPTIONS_ALL="debug -t -l -s -a -f -v -h --tags= --list --steps --allsteps --format= --version --help"
  local OPTIONS_BLANK=""
  local OPTIONS_FORMAT="html json junit progress"
  case $PREV in
      debug)
        COMPREPLY=( $( compgen -W "${OPTIONS_BLANK}" -- "${CUR}" ) )
        return 0
      ;;
      -h|--help)
          COMPREPLY=( $( compgen -W "${OPTIONS_BLANK}" -- "${CUR}" ) )
          return 0
      ;;
      -v|--version)
          COMPREPLY=( $( compgen -W "${OPTIONS_BLANK}" -- "${CUR}" ) )
          return 0
      ;;
      -f|--format=)
          COMPREPLY=( $( compgen -W "${OPTIONS_FORMAT}" -- "${CUR}" ) )
          return 0
      ;;
      -a|--allsteps)
          COMPREPLY=( $( compgen -W "${OPTIONS_BLANK}" -- "${CUR}" ) )
          return 0
      ;;
      -s|--steps)
          COMPREPLY=( $( compgen -W "${OPTIONS_BLANK}" -- "${CUR}" ) )
          return 0
      ;;
      -l|--list)
          COMPREPLY=( $( compgen -W "${OPTIONS_BLANK}" -- "${CUR}" ) )
          return 0
      ;;
      -t|--tags=)
          COMPREPLY=( $( compgen -W "${OPTIONS_BLANK}" -- "${CUR}" ) )
          return 0
      ;;
      *)
          if [[ "${CUR}" == * ]]; then
              COMPREPLY=( $( compgen -W "${OPTIONS_ALL}" -- "${CUR}" ) )
          fi
          return 0
      ;;
  esac
}

complete -F _gauntlt_completion gauntlt
