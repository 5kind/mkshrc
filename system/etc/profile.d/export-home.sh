export_home(){
    local neohome=$1
    if [ -d "$neohome" ] ;then
        export HOME=$neohome
    else
        export HOME=/
	return 1
    fi
}

# export root/shell home
if [ "$USER_ID" = 0 ] ;then
    export_home /data/local/root
elif [ "$USER_ID" = 2000 ] ;then
    export_home /data/user_de/0/com.android.shell/files
else
    export HOME=/
fi
# elif; export_home /data/data/com.termux/files/home ;then ...
# # export termux home is disable by default.
unset -f export_home
