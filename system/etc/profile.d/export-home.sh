export_home(){
    local newhome=$1
    if [ -d "$newhome" ] && [ -x "$newhome" ] ;then
        export HOME=$newhome
    else
        export HOME=/
	    return 1
    fi
}

# export root/shell HOME
# you can mklink /data/local/root -> /data/data/com.termux/files/home/.suroot
if [ "$USER_ID" = 0 ] ;then
    export_home /data/local/root
elif [ "$USER_ID" = 2000 ] ;then
    export_home /data/user_de/0/com.android.shell/files
else
    export_home /data/data/com.termux/files/home ||
    export HOME=/
fi

unset -f export_home
