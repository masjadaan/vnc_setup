#!/bin/bash

echo "Installing VNC Server"
sudo apt install -y tigervnc-standalone-server xfce4-session

echo "Setup your VNC password"
vncserver

echo "Configure VNC Server"
cat <<EOL > ${HOME}/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
EOL

chmod +x ${HOME}/.vnc/xstartup

cat <<EOL > ${HOME}/.vnc/config
geometry=1920x1080
dpi=96
EOL

echo "Creating Systemd Service"
sudo tee /etc/systemd/system/vncserver@.service > /dev/null <<EOL
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=simple
User=%u
PAMName=login
PIDFile=/home/%u/.vnc/%H%i.pid
ExecStartPre=/bin/bash -c '/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver :%i -alwaysshared -fg
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOL

echo "Reload systemd"
sudo systemctl daemon-reload
sleep 0.3
echo

echo "Enable VNC service"
sudo systemctl enable vncserver@1.service
sleep 0.3
echo

echo "Start VNC service"
sudo systemctl start vncserver@1.service
sleep 0.3
echo

echo "Read VNC server port number"
ss -tulpn | grep -i Xtigervnc
echo "Everything is ready on server-side, go to client."
echo
