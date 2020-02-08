#!/usr/bin/sh

# just for debugging
#set -x

# constants
INTERACTIV=0
choice=0
basePath=/sys/class/backlight
graphicCards=($(ls -d $basePath/*))

if [[ $INTERACTIV -eq 1 ]]; then
  printf "Choose your graphic card\n"

  for i in "${!graphicCards[@]}"; do 
     printf "%s\t%s\n" "$i" "${graphicCards[$i]}"
  done

  read choice
fi

brightnessFile=${graphicCards[$choice]}/brightness
currentValue=$(cat $brightnessFile)
maxValue=$(cat ${graphicCards[$choice]}/max_brightness)
minValue=$(($maxValue / 100))
helpMessage="Call: set-backlight [OPTION] value

 If the value is to high or low the max or min value will be used.
  -a, --absolute    Assigns an absolute value 
  -r, --relative    Assign a relative value in percent 
  -u, --up          Increase the brightness relative
  -d, --down        Decrease the brightness relative
  -h, --help        Display this help


This is kiss aproache to solve a problem encountered by the usage of an intel backlight drive. it's straight forward assigning values to the system files. Feel free to use, change or improve this script for your own usecase.

Github: https://github.com/MortenManzelmann/set-backlight
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
  echo "$helpMessage"
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
    echo "$helpMessage"
    ;;
esac

if [[ ! -z $value ]]; then setBrightness; fi

exit 0
