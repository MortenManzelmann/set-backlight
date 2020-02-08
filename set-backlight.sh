#!/usr/bin/sh

# just for debugging
#set -x

# constants
basePath=/sys/class/backlight/intel_backlight/
brightnessFile=$basePath/brightness
currentValue=$(cat $brightnessFile)
maxValue=$(cat $basePath/max_brightness)
minValue=$(($maxValue / 100))
helpMessage="Call: set-backlight [OPTION] value\n\n

 If the value is to high or low the max or min value will be used.\n
  -a, --absolute    Assigns an absolute value \n
  -r, --relative    Assign a relative value in percent\n 
  -u, --up          Increase the brightness relative\n
  -d, --down        Decrease the brightness relative\n
  -h, --help        Display this help\n\n

This is kiss aproache to solve a problem encountered by the usage of an intel backlight drive. it's straight forward assigning values to the system files. Feel free to use, change or improve this script for your own usecase.
  "
# script arguments
option=$1;
value=$2;

setBrightness(){
if [[ $value  -lt  $minValue ]]; then
  echo $minValue > $brightnessFile
elif [[ $value -gt $maxValue ]]; then
  echo $maxValue > $brightnessFile
else
  echo $value > $brightnessFile
fi
}

if [[ "$#" -gt 2 ]]; then
  echo "Uups wrong usage. Take a look in the usage."
  echo $helpMessage
  exit 1
fi

case "$option" in
  -a|--absolute) 
    ;;
  -r|--relative)
    value=$(($value * $maxValue / 100))
    ;;
  -u|--up)
    value=$(($currentValue + $value * $maxValue / 100))
    ;;
  -d|--down)
    value=$(($currentValue - $value * $maxValue / 100))
    ;;
  -h|--help|*)
    echo $helpMessage
    ;;
esac

setBrightness

exit 0




