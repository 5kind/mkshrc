export_home(){
    local newhome=$1
    if [ -d "$newhome" ] && [ -x "$newhome" ] ;then
        export HOME=$newhome
    else
	    return 1
    fi
}

# export root/shell HOME
if [ "$USER_ID" = 0 ] ;then         # root
    export_home /data/data/com.termux/files/home/.suroot
elif [ "$USER_ID" = 2000 ] ;then    # shell
    export_home /data/user_de/0/com.android.shell/files
else                                # termux
    export_home /data/data/com.termux/files/home
fi || export HOME=/sdcard           # failback

unset -f export_home
