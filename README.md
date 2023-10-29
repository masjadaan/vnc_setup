# VNC Server and Client Setup

This repository includes two shell scripts designed to facilitate the setup of a VNC (Virtual Network Computing) server and client. These scripts enable graphical user interface (GUI) connectivity to a Linux computer or Raspberry Pi, offering a functionality similar to RDP (Remote Desktop Protocol) on Windows machines. The server script is intended to be run on the remote machine, while the client script is used on the local machine.

## Requirment
- Ensure that you have SSH access to the remote machine before setting up the VNC server and using the VNC client.

## VNC Server Setup (vnc_server.sh)

### Purpose:
The vnc_server.sh script automates the setup of a VNC server on a remote machine. It installs the necessary software, configures VNC, and creates a systemd service for remote desktop access.

### Usage:
- Run the script on the server machine:
```bash
chmod +x vnc_server.sh
./vnc_server.sh
```

- Follow the on-screen instructions to set up a VNC password and configure the server's display settings.

- The script will create a systemd service for the VNC server, allowing it to start on boot and be managed using systemd.

- After setup, you can connect to the VNC server using a VNC client from your local machine.


## VNC Client Setup (vnc_client.sh)

### Purpose:
The vnc_client.sh script is used on your local machine to connect to the remote VNC server securely via SSH tunneling. It installs a VNC client and sets up an SSH tunnel for secure communication.

### Usage:
- Run the script on the local machine, providing the required parameters:
```bash
./vnc_client.sh <username> <remote_ip> <ssh_port> <vnc_port>
	<username>: The username on the remote machine.
	<remote_ip>: The IP address of the remote machine with the VNC server.
	<ssh_port>: The SSH port on the remote machine.
	<vnc_port>: The VNC port used for the tunnel.
```
- The script will establish an SSH tunnel with port forwarding, securing the VNC connection.

- Once the tunnel is established, the script will initiate the VNC client, allowing you to interact with the remote desktop environment.

#### Note:
- For additional security, consider using SSH keys and adjusting your SSH configuration.
- When using Kali Linux, we typically employ the "startxfce4" desktop environment. However, on different operating systems, particularly Raspberry Pi setups, this desktop environment may not come pre-installed. Therefore, when executing this script on any server, it's important to first determine the available desktop environments and adapt the script accordingly. For example, for Raspberry PI, I would replace startxfce4 with startx
```bash
apt list | grep -i ubuntu-desktop
# OR
apt list | grep -i kali-desktop
```
