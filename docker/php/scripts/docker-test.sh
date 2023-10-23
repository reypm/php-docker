#!/bin/sh

for i in dir1 dir2 dir3; do
    if [ -d "${SCANDISK_MOUNT}/$i" ]; then
        # no need to continue of the folder is created
        continue
    fi

    case $i in
    'dir1')
        mkdir -p "${SCANDISK_MOUNT}/$i/{subdir1,subdir2,subdir3}"
    ;;
    'dir2')
        mkdir -p "${SCANDISK_MOUNT}/$i/{subdir4,subdir5,subdir6}"
    ;;
    'dir3')
        # Dont do anything here
    ;;
    *)
        # Create a processed folder inside
        mkdir -p "${SCANDISK_MOUNT}/$i/processed"
    ;;
    esac
done

# Create another folders need it
mkdir -p "${SCAN_MOUNT}/{subdir7,subdir8}"

# Give permissions to the folders
chown -R www-data "${SCAN_MOUNT}" "${SCANDISK_MOUNT}"
