#!/bin/bash

lock()
{
  if ! i3lock --show-failed-attempts --ignore-empty-password --color=202020; then
    i3lock --color=202020
  fi
  return
}

logout()
{
  i3-msg exit
  return
}

reboot()
{
  systemctl reboot
  return
}

shutdown()
{
  systemctl poweroff
  return
}

usage()
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
