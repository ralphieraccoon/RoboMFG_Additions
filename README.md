# RoboMFG Additions
Additional configs and scripts for the AMPI robotics manufacturing platform

# Installation
SSH into your pi and enter the following commands

```
cd ~/
git clone https://github.com/Advanced-Manufacturing-at-UoL/RoboMFG_Additions.git
bash ~/RoboMFG_Additions/install.sh
```

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
