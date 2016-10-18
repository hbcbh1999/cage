deactivate () {
    # reset old environment variables
    # ! [ -z ${VAR+_} ] returns true if VAR is declared at all
    if ! [ -z "${_OLD_PATH+_}" ] ; then
        PATH="$_OLD_PATH"
        export PATH
        unset _OLD_PATH
    fi

    # This should detect bash and zsh, which have a hash command that must
    # be called to get it to forget past commands.  Without forgetting
    # past commands the $PATH changes we made may not be respected
    if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then
        hash -r 2>/dev/null
    fi

    if ! [ -z "${_OLD_PS1+_}" ] ; then
        PS1="$_OLD_PS1"
        export PS1
        unset _OLD_PS1
    fi

    unset CAGE_ENV
    unset -f deactivate
}

CAGE_ENV="__CAGE_ENV__"
export CAGE_ENV

# TODO: Detect if directory still exists and change __CAGE_ENV__ accordingly

_OLD_PATH="$PATH"

# TODO: Remove hardcoded path and replace with some sort of install path

PATH="$CAGE_ENV:$PATH"
export PATH

_OLD_PS1="$PS1"
PS1="(`basename \"$CAGE_ENV\"`) $PS1"
export PS1

if [ -n "${BASH-}" ] || [ -n "${ZSH_VERSION-}" ] ; then
    hash -r 2>/dev/null
fi
