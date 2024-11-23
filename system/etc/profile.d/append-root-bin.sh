for system_bin in /*/*bin; do
    append_path $system_bin
done

for root_bin in $(ls -d /data/adb/magisk \
    /data/adb/*/bin 2>/dev/null); do
    append_path $root_bin
done
