# Prevent running as root.
if [ ${UID} == 0 ]; then
    echo -e "DO NOT RUN THIS SCRIPT AS 'root' !"
    echo -e "If 'root' privileges needed, you will prompted for sudo password."
    exit 1
fi

# Force script to exit if an error occurs
set -e

# Find SRCDIR from the pathname of this script
SRCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/ && pwd )"

# Default Parameters
CONFIG_DIR="${HOME}/printer_data/config"

function start_klipper {
    sudo systemctl restart klipper
}

function stop_klipper {
    # if [ "$(sudo systemctl list-units --full -all -t service --no-legend | grep -F "klipper.service")" ]; then
    if [ "$(sudo systemctl list-units -t service --no-legend | grep -F "klipper.service")" ]; then
        sudo systemctl stop klipper
    else
        echo "Klipper service not found, please install Klipper first"
        exit 1
    fi
}

function copy_additions_folder {
    if [ -d "${CONFIG_DIR}" ]; then
        if [ -d "${CONFIG_DIR}/additions" ]; then
            echo -e "${CONFIG_DIR}/additions already exists, skipping..."
        else
            sudo cp -av ${SRCDIR}/additions ${CONFIG_DIR}/additions
            echo -e "additions folder coppied"
        fi
    else
        echo -e "ERROR: ${CONFIG_DIR} not found."
        exit 1
    fi
}

function copy_board_files {
    if [ -d "${CONFIG_DIR}" ]; then
        sudo cp -av "${SRCDIR}/RatOS/boards/btt-ebb42-12b" "${CONFIG_DIR}/RatOS/boards"
        echo -e "BTT EBB42 V1.2 board files copied"
    else
        echo -e "ERROR: ${CONFIG_DIR} not found."
        exit 1
    fi
}

function copy_cfg_template {
    if [ -d "${CONFIG_DIR}" ]; then
        cp "${SRCDIR}/.RoboMFG_Template_printer.cfg" "${CONFIG_DIR}/.RoboMFG_Template_printer.cfg"
        echo -e "printer.cfg template copied"
    else
        echo -e "ERROR: ${CONFIG_DIR} not found."
        exit 1
    fi
}

function update_udev_rules {
    if [ -d "${CONFIG_DIR}" ]; then
        sudo ~/printer_data/config/RatOS/scripts/ratos-update.sh
        echo -e "Udev rules updated"
    else
        echo -e "ERROR: ${CONFIG_DIR} not found."
        exit 1
    fi
}

function install_ktcc {
    cd ~
    git clone https://github.com/TypQxQ/Klipper_ToolChanger.git
    bash ~/Klipper_ToolChanger/install.sh
    echo -e "KTCC installed"
}

function install_z_calibration {
    cd ~
    git clone https://github.com/protoloft/klipper_z_calibration.git
    bash ~/klipper_z_calibration/install.sh
    echo -e "Automatic Z-Calibration installed"
}

function install_dynamixel {
    cd ~/
    git clone https://github.com/Advanced-Manufacturing-at-UoL/RoboMFG_Dynamixel.git
    bash ~/RoboMFG_Dynamixel/install.sh
    echo -e "Dynamixel installed"
}

echo -e "RoboMFG Additions"
stop_klipper
copy_additions_folder
# copy_board_files
copy_cfg_template
# update_udev_rules
start_klipper
install_ktcc
install_z_calibration
install_dynamixel

echo -e ""
echo -e "Installation finished!"
echo -e ""
exit 0
