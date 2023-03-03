# RatOS-RoboMFG-Additions
Additional configs and scripts for the AMPI robotics manufacturing platform

# Installation
SSH into your pi and enter the following commands

```
cd ~/printer_data/config
git clone https://github.com/ShuttleworthM/RatOS-RoboMFG-Additions.git RoboMFG
mv printer.cfg printer_OLD.cfg
cp ~/printer_data/config/RoboMFG/template/robomfg-printer.template.cfg ~/printer_data/config/printer.cfg
systemctl restart klipper
```

# Update Manager
To recieve updates from the git repo add the following lines to the bottom of the moonraker.conf file

```
[update_manager RoboMFG]
type: git_repo
path: ~/printer_data/config/RoboMFG
origin: https://github.com/ShuttleworthM/RatOS-RoboMFG-Additions.git
primary_branch: main
is_system_service: False
```
