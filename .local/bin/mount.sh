#!/bin/bash
# This is a fork of https://github.com/luyves/polybar-rofi-usb-mount
# I wanted it to be generic, not polybar. It presents a menu to mount or unmount and also can locate usb disks without partitions (super-floppy structure) which the original couldn't.

usbcheck(){ \
    mounteddrives="$(lsblk -rpo "name,type,size,mountpoint" | grep 'sd' | awk '$4{print $1,$3}')"
    if [ $(echo "$mounteddrives" | wc -l) -gt 0 ]; then
        echo "  #  $mounteddrives"
    else
        if [ $(echo "$usbdrives" | wc -l) -gt 0 ]; then
            echo "  #  "
        else
            echo ""
        fi
    fi
}

mountusb(){ \
    chosen=$(echo "$usbdrives" | tofi | awk '{print $1}')
    mountpoint=$(udisksctl mount --no-user-interaction -b "$chosen" 2>/dev/null) && notify-send "USB mounting" "$mountpoint" && exit 0

}

umountusb(){ \
    chosen=$(echo "$mounteddrives" | tofi | awk '{print $1}')
    mountpoint=$(udisksctl unmount --no-user-interaction -b "$chosen" 2>/dev/null) && notify-send "USB unmounting" "$mountpoint" && exit 0
    udisksctl unmount --no-user-interaction -b "$chosen"
}

umountall(){ \
	for chosen in $(echo $(lsblk -rnpo name,size,mountpoint,fstype | grep 'sd' | awk 'NF==4 {print $1}')); do
        udisksctl unmount --no-user-interaction -b "$chosen"
    done
}

usbdrives="$(lsblk -rnpo name,size,mountpoint,fstype | grep 'sd' | awk 'NF==3 {print $1, $2, $3}')"
mounteddrives="$(lsblk -rnpo name,size,mountpoint,fstype | grep 'sd' | awk 'NF==4 {print $1, $2, $3, $4}')"

menu(){ \
	epilogimenu=$(echo -e "Mount\nUmount\nUmountAll" | tofi | awk '{print $1}')
}

menu

case $epilogimenu in
    check)
        usbcheck
        ;;
    Mount)
        if [ $(echo "$usbdrives" | wc -w) -gt 0 ]; then
            mountusb
        else
            notify-send "No USB drive(s) detected." && exit
        fi
        ;;
    Umount)
        if [ $(echo "$mounteddrives" | wc -w) -gt 0 ]; then
            umountusb
        else
            notify-send "No USB drive(s) to unmount." && exit
        fi
        ;;
    UmountAll)
        if [ $(echo "$mounteddrives" | wc -w) -gt 0 ]; then
            notify-send "Unmounting all USB drives."
            umountall
        else
            notify-send "No USB drive(s) to unmount." && exit
        fi
         ;;
esac
