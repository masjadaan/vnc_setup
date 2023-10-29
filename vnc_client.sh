#!/bin/sh
echo "Install VNC Client"
sudo apt install tigervnc-viewer

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <username> <remote_ip> <ssh_port> <vnc_port>"
  exit 1
fi

username="$1"
remote_ip="$2"
ssh_port="$3"
vnc_port="$4"

echo "create SSH tunnel with port forwarding"
ssh -p "$ssh_port" -L "$vnc_port":127.0.0.1:"$vnc_port" -N -f -l "$username" "$remote_ip"

echo "Connecting to Remote VNC Server"
vncviewer localhost:"$vnc_port"
