# =================================================================
#  Sudo-Lite Function
# =================================================================
# This script provides a lightweight sudo-like functionality which
# only takes effect when the system finds the su executable.

# 1. Looking forward to the su executable.
_SU_BINARY=""
# Check if the su executable exists.
for _su_path in /system/xbin/su /system/bin/su /sbin/su; do
    if [ -x "$_su_path" ]; then
        _SU_BINARY="$_su_path"
        break
    fi
done
unset _su_path

# 2. Define the sudo-lite function if the su executable exists.
if [ -n "$_SU_BINARY" ] && ! command -v sudo >/dev/null 2>&1; then
    function sudo {
        # Define the sudo-lite function.
        # Usage: sudo [-E] [-u USER] command
        _sudo_usage() {
            print -r -- 'sudo - run commands as root or another user'
            print -r -- '  usage: sudo command'
            print -r -- '  usage: sudo [-E] [-u USER] command'
            print -r -- ''
            print -r -- '    Options:'
            print -r -- '      -E          Preserve environment variables from the current shell.'
            print -r -- '      -u USER     Switch to USER instead of root..'
        }

        if [ "$1" = '--help' ]; then
            _sudo_usage
            return 0
        fi

        local _preserve_env=false
        local _switch_user=""
        local OPTIND OPTARG

        while getopts "Eu:h" opt; do
            case "$opt" in
                E) _preserve_env=true ;;
                u) _switch_user="$OPTARG" ;;
                h)
                    _sudo_usage
                    return 0
                    ;;
                \?)
                    _sudo_usage
                    return 1
                    ;;
            esac
        done

        # Remove processing options from the argument list
        shift $((OPTIND - 1))

        if [ $# -eq 0 ]; then
            _sudo_usage
            return 1
        fi

        # Build the su command arguments
        local _su_args=""
        if [ -n "$_switch_user" ]; then
            _su_args="$_su_args $_switch_user"
        fi
        if $_preserve_env; then
            _su_args="$_su_args --preserve-environment"
        fi

        # Execute the su command
        exec "$_SU_BINARY" $_su_args -c "$*"
    }
fi

unset _SU_BINARY
