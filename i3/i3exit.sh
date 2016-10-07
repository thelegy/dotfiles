#!/bin/bash

function lock()
{
  if ! i3lock --show-failed-attempts --ignore-empty-password --color=202020; then
    i3lock -ccolor=202020
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
