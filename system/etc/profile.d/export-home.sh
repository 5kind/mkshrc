HOME=/data/local/root

export_home(){
    if [ -d $HOME ] ;then
        export HOME
    else
        export HOME=/
    fi
}

# export root/shell home
if (( ! USER_ID )) ;then
    HOME=/data/local/root
    export_home
elif (( USER_ID == 2000 )) ;then
    HOME=/data/user_de/0/com.android.shell/files
    export_home
else
    HOME=/
    export HOME
fi
# else
#     HOME=/data/data/com.termux/files/home
#     export_home
# # export termux home is disable by default.
