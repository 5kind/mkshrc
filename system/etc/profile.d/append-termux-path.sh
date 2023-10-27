PREFIX=/data/data/com.termux/files/usr

append_exist_path(){
    local newpath="$1"
    if [ -d "$newpath" ] ;then
        append_path "$newpath"
        return 0
    else
        return 1
    fi
}

append_exist_path $PREFIX/bin # ||
unset PREFIX
unset -f append_exist_path
