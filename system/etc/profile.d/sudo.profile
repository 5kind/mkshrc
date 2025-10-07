# =====================================================
# Sudo-lite: A minimal sudo replacement using su
# Compatible with MagiskSU, KerenelSU, APatch
# =====================================================

_SUDO_VERSION="0.1.0"

[ -z "$_SU_BINARY" ] && _SU_BINARY="su"

_sudo_usage(){
    cat << EOF
sudo-lite - run commands as root or another user

usage: sudo -h | -V
usage: sudo [-Ei] [-u user] [command [arg ...]]

Options:
  -E, --preserve-env            preserve user environment when running command
  -i, --login                   run login shell as the target user
  -u, --user=user               run command as specified user name or ID
  --                            stop processing command line arguments
  -h, --help                    display help message
  -V, --version                 display version information
EOF
}

_sudo_version() {
    echo "Sudo-Lite version $_SUDO_VERSION"
    "$_SU_BINARY" -v 2>/dev/null || echo "Could not determine su version."
}

sudo(){
    _SU_ARGS=""
    _SU_EXEC=""
    _TARGET_USER=""
    _LOGIN_FLAG=false

    while [ "$#" -gt 0 ]; do
        case "$1" in
            -h|--help)
                _sudo_usage
                return 0
                ;;
            -V|--version)
                _sudo_version
                return 0
                ;;
            -E|--preserve-env)
                _SU_ARGS="$_SU_ARGS -p"
                ;;
            -i|--login)
                _LOGIN_FLAG=true
                ;;
            -u)
                _TARGET_USER="$2"
                shift
                ;;
            --user=*)
                _TARGET_USER="${1#*=}"
                ;;
            --)
                shift
                break
                ;;
            *)
                _SU_EXEC="$@"
                break
                ;;
        esac
        shift
    done

    if [ -z "$_SU_EXEC" ] && $_LOGIN_FLAG; then
        eval "$_SU_BINARY $_SU_ARGS $_TARGET_USER -l"
        return $?
    elif [ -n "$_SU_EXEC" ]; then
        eval "$_SU_BINARY $_SU_ARGS $_TARGET_USER -c \"$_SU_EXEC\""
        return $?
    else
        _sudo_usage
        return 1
    fi
}

# ======================================================
# Helper functions
# ======================================================
_sudo_check(){
    if [ -z "$_SU_EXEC" ]; then
        _sudo_usage
        return 1
    fi
}

# ======================================================
# Main (run as sudo script)
# ======================================================
if [ "${0##*/}" = "sudo" ]; then
    sudo "$@"
fi
