# cups
Docker container with cups and avahi. It already included required configs for my LaserJet M1120.

## docker cli

```
docker run \
  --name cups \
  --network host \
  --privileged \
  --device /dev/bus/usb/002/003 \
  -v /var/run/dbus:/var/run/dbus \
  pavel-alay/cups
```
Privileged is required to access usb device. The usb device itself can be detected via `lsusb`. `/var/run/dbus` is required for avahi, i.e. for AirPrint.

# docker-compose

```
---
version: "2.1"
services:
  cups:
    privileged: true
    image: pavel-alay/cups
    container_name: cups
    network_mode: host
    devices:
      - /dev/bus/usb/002/003
    volumes:
      - /var/run/dbus:/var/run/dbus  
    restart: unless-stopped
```
