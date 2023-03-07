#!/bin/bash
MCU=/dev/serial/by-id/usb-Klipper_stm32g0b1xx_fff_head_2-if00
if [ "$EUID" -ne 0 ]
  then echo "ERROR: Please run as root"
  exit
fi
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
FLASH_SCRIPT=$(realpath "$SCRIPT_DIR/../flash-path.sh")
$FLASH_SCRIPT $MCU
