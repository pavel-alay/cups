#!/bin/bash -e

rm -f /run/dbus/pid
dbus-daemon --system
avahi-daemon -D --no-drop-root

/usr/sbin/cupsd -f