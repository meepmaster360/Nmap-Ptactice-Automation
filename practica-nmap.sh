#!/bin/bash

echo "Welcome to Nmap Practice Automatization!!"
echo "\nRelax and enjoy, to advance you just have to press 'Enter'."

read "enter"

echo "Let's make the identification of our network.\n"
sudo ifconfig
echo "\nIdentify your NAT IP assigned to port eth0.\n"

echo "Enter the network ID and its netmask (/24): "
read netID
sudo nmap $netID

echo "\nIdentifies the NAT IP assigned to the victim machines.\nNote: These are the two IPs that have the most open ports.\n"

echo "\nEnter the IP of the first target:"
read target1

echo "\nEnter the IP of the second target:"
read target2

opt=0

clear


while [ $opt -ne 11 ]; do

echo "\n\nWelcome to the nmap attacks menu, please choose the desired option.\n"
echo "[1] Run a search of all hosts via ping."
echo "[2] Run a search for all IPs connected to the network."
echo "[3] Discover all services with open ports and versions on each host."
echo "[4] Detect the Operating Systems of all connected hosts."
echo "[5] Detect all vulnerabilities (CVEs) associated with services."
echo "[6] Do a MySQL password brute force attack."
echo "[7] Detect insecure configurations in MySQL."
echo "[8] Determine the plugins installed in Wordpress."
echo "[9] Determine the list of users in the WordPress installation."
echo "[10] Perform a brute force attack on the Wordpress admin user."
echo "[11] Exit\n"

read -p "Option: " opt

case $opt in

        1) clear
             echo "Option 1\n"
             sudo nmap $netID  -sP
             ;;

        2) clear
             echo "Option 2"
             sudo nmap $netID
             ;;

        3) clear
             echo "Option 3"
             sudo nmap $target1 $target2 -sV
             ;;

        4) clear
             echo "Option 4"
             sudo nmap -sV -O -v $target1 $target2
             ;;

        5) clear
             echo "Option 5"
             
             
             sudo nmap --script nmap-vulners/ -sV $target1 $target2
             ;;

        6) clear
             echo "Option 6"
             sudo nmap -p 3306 --script mysql-brute $target1 $target2
             ;;

        7) clear
             echo "Option 7"
             nmap -p 3306 --script mysql-audit --script-args mysql-audit.filename=/usr/share/nmap/nselib/data/mysql-cis.audit,mysql-audit.username=root,mysql-audit.password= $target1 $target2
             ;;

        8) clear
             echo "Option 8"
             nmap -sV --script http-wordpress-enum $target1 $target2
             ;;

        9) clear
             echo "Option 9"
             nmap -sV --script http-wordpress-users --script-args limit=10 $target1 $target2
             ;;

        10) clear
             echo "Option 10"
             nmap -sV --script http-wordpress-brute $target1 $target2
             ;;

        11) clear
             echo "bye"
             ;;

        *) echo $opt  "This is not a valid option"
             ;;


esac

done
