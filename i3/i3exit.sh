#!/bin/bash

function lock()
{
    local tmpscreenshot="/tmp/i3lock_screenshot.png"
    if hash import && hash convert; then
        import -window root "${tmpscreenshot}"
        convert "${tmpscreenshot}" \
                -resize 25% \
                -gaussian-blur 4 \
                -resize 400% \
                "${tmpscreenshot}"
        i3lock -defi "${tmpscreenshot}"
    else
        i3lock -defc 003B65
    fi
    return
}

function logout()
{
    i3-msg exit
    return
}

function reboot()
{
    systemctl reboot
    return
}

function shutdown()
{
    systemctl poweroff
    return
}

function usage()
{
    echo "$0 (lock|logout|reboot|shutdown)"
    return
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        logout
        ;;
    reboot)
        reboot
        ;;
    shutdown)
        shutdown
        ;;
    *)
        usage
        exit 2
        ;;
esac

exit 0
