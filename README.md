# RoboMFG Additions
Additional configs and scripts for the AMPI robotics manufacturing platform

# Installation
Using a web browser, connect to ratos.local and from the Mainsail interface run click the "INSTALL VCORE THREE CONFIG" button.

After, SSH into the pi and enter the following commands

```
cd ~/
git clone https://github.com/Advanced-Manufacturing-at-UoL/RoboMFG_Additions.git
bash ~/RoboMFG_Additions/install.sh
```
Next, copy the contents of moonraker.cfg from https://github.com/Advanced-Manufacturing-at-UoL/RoboMFG-Config-Backup/blob/Dev/moonraker.conf and paste them into the moonraker.conf file found in the root config file found in the Mainsail interface on the "MACHINE" tab, then click "save and restart"

# Update Manager
To recieve updates from the git repo add the following lines to the bottom of the moonraker.conf file

```
[update_manager RoboMFG]
type: git_repo
primary_branch: main
path: ~/Robot-MFG-Platform_RatOS-Additions
origin: https://github.com/Advanced-Manufacturing-at-UoL/RoboMFG_Additions.git
managed_services: klipper
```
