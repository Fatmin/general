#!/bin/bash
#jump.bash
#Script to list a number of servers and present the option to ssh to these servers
#Includes lots of pretty colors


#Variables
#modify these to meet your needs and to match what you have below
ID=
SERVER1=
SERVER2=
SERVER3=
SERVER4=
SERVER5=
SERVER6=
SERVER7=
SERVER8=
SERVER9=

#Make R2-D2 Sound
#Uncomment and customize the line below to play a custom sound
#aplay -q /home/R2D2-yeah.wav


#Color Function
function coloredEcho(){
    local exp=$1;
    local color=$2;
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput bold
    tput setaf $color;
    echo $exp;
    tput sgr0;
}

#clear the screen
clear

while :
do 
coloredEcho "-----------------------" magenta
coloredEcho "Choose Your Jump Server" magenta
coloredEcho "-----------------------" magenta
echo ""
coloredEcho "Glenlake Prod" magenta
coloredEcho "[a] $ID@$SERVER1" yellow
coloredEcho "[b] $ID@$SERVER2" yellow
echo ""
coloredEcho "Atlanta Metro" magenta
echo ""
coloredEcho "DEV" magenta
coloredEcho "[c] $ID@$SERVER3" green
coloredEcho "[d] $ID@$SERVER4" green
echo ""
coloredEcho "QA" magenta
coloredEcho "[e] $ID@$SERVER5" cyan
coloredEcho "[f] $ID@$SERVER6" cyan
echo ""
coloredEcho "GPN" magenta
coloredEcho "[g] $ID@$SERVER7" blue
coloredEcho "[h] $ID@$SERVER8" blue
echo ""
coloredEcho "PROD" magenta
coloredEcho "[i] $ID@$SERVER9" red
coloredEcho "[j] $ID@$SERVER10" red
echo ""
coloredEcho "Additional Options" magenta
echo "* [x] Exit"
echo ""
echo -n "Choose Wisely [a-j]:" 
read yourch
case $yourch in
a) ssh $ID@$SERVER1;;
b) ssh $ID@$SERVER2;;
c) ssh $ID@$SERVER3;;
d) ssh $ID@$SERVER4;;
e) ssh $ID@$SERVER5;;
f) ssh $ID@$SERVER6;;
g) ssh $ID@$SERVER7;;
h) ssh $ID@$SERVER8;;
i) ssh $ID@$SERVER9;;
j) ssh $ID@$SERVER10;;
x) exit 0;;
*) coloredEcho "You Have Choosen Poorly..." magenta
coloredEcho "Press Enter to Continue"  magenta
read ;;
esac
done
