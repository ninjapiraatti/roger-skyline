#!/bin/bash
clear
read -p $'\e[1;36mHenlo. I am Booblesnoot and I will guide you through this evaluation process.\nBoop ENTER.\n\e[0m'
read -p $'\n\e[1;36mOk, great! First, let me demonstrate that the VM is not running Docker, Vagrant or
Traefik. I\'m gonna execute:
\e[1;35m
sudo apt list --installed | grep Docker
sudo apt list --installed | grep Vagrant
sudo apt list --installed | grep Traefik
\e[1;36m\nBoop ENTER.\n\e[0m'
sudo apt list --installed | grep Docker
sudo apt list --installed | grep Vagrant
sudo apt list --installed | grep Traefik
read -p $'\n\e[1;36mNice. Next, let me demonstrate that there are partitions on this VM. I\'m gonna execute:
\e[1;35m
lsblk
\e[1;36m\nBoop ENTER.\n\e[0m'
lsblk
read -p $'\n\e[1;36mVery cool! Next up, I\'m going to show you that the packages are up to date.
I\'m gonna run the update and upgrage commands and none of the packages should need either. About to run:
\e[1;35m
sudo apt update
sudo apt upgrade
\e[1;36m\nBoop ENTER.\n\e[0m'
sudo apt update
sudo apt upgrade
read -p $'\n\e[1;36mMoving on to Network and Security part. The sudo user is already created (ninjapiraatti).
It\'s actually that user that is running all these commands too. If we\'d create a new sudo user, the
commands would be:
\e[1;35m
sudo adduser [username]
sudo usermod -aG sudo [username]
\e[1;36m\nBoop ENTER.\n\e[0m'
read -p $'\n\e[1;36mThe subject says we want a static ip and get rid of DHCP. First, the VM setting
for network is set to bridged instead of NAT. Then the network configurations are made. I will now
run two commands to display contents of these files:
\e[1;35m
cat /etc/network/interfaces
cat /etc/network/interfaces.d/enp0s3
\e[1;36m\nBoop ENTER.\n\e[0m'
cat /etc/network/interfaces
cat /etc/network/interfaces.d/enp0s3
read -p $'\n\e[1;36miface enp0s3 inet static means that dhcp is disabled and the VM has a static ip.
\nNext, we\'re going to change the netmask. This is not done programmatically so we will display the
updated conf when ready:
\e[1;35m
cat /etc/network/interfaces.d/enp0s3
\e[1;36m\nBoop ENTER.\n\e[0m'
cat /etc/network/interfaces.d/enp0s3
read -p $'\n\e[1;36mDisplaying the lines I needed to change in sshd_config in order to change port to 50010,
disallow root and disallow password login:
\e[1;35m
cat /etc/ssh/sshd_config | grep 50010
cat /etc/ssh/sshd_config | grep PermitRootLogin
cat /etc/ssh/sshd_config | grep PasswordAuthentication
\e[1;36m\nBoop ENTER.\n\e[0m'
cat /etc/ssh/sshd_config | grep 50010
cat /etc/ssh/sshd_config | grep PermitRootLogin
cat /etc/ssh/sshd_config | grep PasswordAuthentication
read -p $'\n\e[1;36mNow showing UFW setup:
\e[1;35m
sudo ufw status
\e[1;36m\nBoop ENTER.\n\e[0m'
sudo ufw status
read -p $'\n\e[1;36mSpectacular. Now, I\'m going to run a DoS test with a program called slowhttptest.
Fail2ban has already been setup to protect the VM from DoS attacks and if slowhttptest runs ok, the
protection is working. I\'m going to first disable Fail2ban to show test results on an unprotected server:
\e[1;35m
sudo fail2ban-client status http-get-dos
sudo fail2ban-client stop
slowhttptest -c 500 -H -g -o ./output_file -i 10 -r 200 -t GET -u http://192.168.0.132 -x 24 -p 2
\e[1;36m\nBoop ENTER.\n\e[0m'
sudo fail2ban-client status http-get-dos
sudo fail2ban-client stop
slowhttptest -c 500 -H -g -o ./output_file -i 10 -r 200 -t GET -u http://192.168.0.132 -x 24 -p 2
read -p $'\n\e[1;36mNow I\'m going to start the fail2ban, run the same test and then display the ban list:
\e[1;35m
sudo fail2ban-client start
slowhttptest -c 500 -H -g -o ./output_file -i 10 -r 200 -t GET -u http://192.168.0.132 -x 24 -p 2
sudo fail2ban-client status http-get-dos
\e[1;36m\nBoop ENTER.\n\e[0m'
sudo fail2ban-client start
slowhttptest -c 500 -H -g -o ./output_file -i 10 -r 200 -t GET -u http://192.168.0.132 -x 24 -p 2
sudo fail2ban-client status http-get-dos
read -p $'\n\e[1;36mI installed portsentry to block port scanning. Printing out the config file next:
\e[1;35m
cat /etc/portsentry/portsentry.conf
\e[1;36m\nBoop ENTER.\n\e[0m'
cat /etc/portsentry/portsentry.conf
read -p $'\n\e[1;36mFabulous. Subject also says to stop unnecessary services. Disabled console-setup,
keyboard-setupa and apparmor. Listing the current running services now:
\e[1;35m
sudo service --status-all
\e[1;36m\nBoop ENTER.\n\e[0m'
sudo service --status-all
read -p $'\n\e[1;36mRunning the update script and displaying the log file next:
\e[1;35m
bash ninja_update.sh
cat /var/log/update_script.log
\e[1;36m\nBoop ENTER.\n\e[0m'
bash ninja_update.sh
cat /var/log/update_script.log
read -p $'\n\e[1;36mThere is also a script for monitoring the tampering of /etc/crontab. It is
configured to send email to the user ninjapiraatti. Next I will show the latest email. This
should update once the crontab is fiddled with:
\e[1;35m
cd mail/new
cat "$(ls -rt | tail -n1)"
\e[1;36m\nBoop ENTER.\n\e[0m'
cd mail/new
cat "$(ls -rt | tail -n1)"
read -p $'\n\e[1;36mThank you! Boop ENTER one last time to exit.\e[0m'




