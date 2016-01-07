#!/bin/bash

WINDOWID="$(xprop -root _NET_ACTIVE_WINDOW | cut -d' ' -f5)"
PID="$(xprop -id ${WINDOWID} _NET_WM_PID|cut -d' ' -f3)"
if (ps h -q ${PID} -o stat | grep T >/dev/null 2>&1); then
    kill -CONT ${PID}
else
    kill -STOP ${PID}
fi
