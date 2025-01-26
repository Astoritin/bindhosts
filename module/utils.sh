#!/bin/sh
## taken from susfs
## susfs_clone_perm <file/or/dir/perm/to/be/changed> <file/or/dir/to/clone/from>
susfs_clone_perm() {
	TO=$1
	FROM=$2
	if [ -z "$TO" ] || [ -z "$FROM" ]; then
		return
	fi
	CLONED_PERM_STRING=$(stat -c "%a %U %G" "$FROM" )
	set "$CLONED_PERM_STRING"
	chmod "$1" "$TO"
	chown "$2:$3" "$TO"
	busybox chcon --reference="$FROM" "$TO"
}

# simple af writable dir lookup
find_rwdir() {
	rwdir=$MODDIR
	[ -w /sbin ] && rwdir=/sbin
	[ -w /debug_ramdisk ] && rwdir=/debug_ramdisk
}

# EOF
