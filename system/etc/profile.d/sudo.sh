# =================================================================
# Sudo-Lite (/etc/profile.d/sudo.sh)
# =================================================================

# 1. Looking forward to the su executable.
_SU_BINARY=""
# Check if the su executable exists.
if ! _SU_BINARY="$(command -v su 2>/dev/null)"; then
    for _su_path in /system/xbin/su /system/bin/su /sbin/su /sbin/bin/su; do
        if [ -x "$_su_path" ]; then
            _SU_BINARY="$_su_path"
            break
        fi
    done
fi
unset _su_path

# 2. Load sudo profile.
if [ -n "$_SU_BINARY" ] && ! command -v sudo >/dev/null 2>&1; then
    . /etc/profile.d/sudo.profile
fi
