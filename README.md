# Roger Skyline

How to create a VM and stuff.

## VM Part

I used Virtualbox and Debian 10. 8GB hard drive was assigned in the installer as was the 4.2GB partition. This can be viewed in the VM with *lsblk.* It doesn't show the partition as 4.2GB but that's working as intended; 4.2GB is actually 4200000000 / (1024 x 1024 x 1024) = 3.9GB. I use this partition as the swap drive.

Updated and upgraded with *apt-get update && apt-get upgrade.*

## Network and Security Part

I created user "ninjapiraatti". Debian doesn't have sudo installed by default so I had to install it: *apt-get install sudo -y.* After this, I had to give "ninjapiraatti" the proper permissions to actually use sudo: *usermod -aG sudo ninjapiraatti.*

-----

With the sudo rights, "ninjapiraatti" was able to install apticron: *sudo apt-get install apticron*

-----

To get rid of DHCP and attain a static IP I modified the /etc/network/interface primary network interface to following on my VM:

auto enp0s3

And interfaces.d/enp0s3 to:

iface enp0s3 inet static
    address 192.168.0.132
    netmask 255.255.255.0
    gateway 192.168.0.1

-----

Changed the default port at /etc/ssh/sshd_config. Uncommented the line with "Port" and changed 22 to 50005. Created a public key on the host machine: *ssh-keygen -t rsa*. Copied the keys to VM: *ssh-copy-id -i /c/Users/Tuomas/.ssh/id_rsa.pub ninjapiraatti@192.168.0.132 -p 50005*.

Changed /etc/ssh/sshd_config to disallow root login: 
PermitRootLogin no
PasswordAuthentication no

Restarted the ssh service with *sudo service sshd restart*. 

-----

Installed Uncomplicated firewall with *sudo apt-get install ufw*

Made the rules:

*ufw allow 50005/tcp* (ssh)
*ufw allow 80/tcp* (http)
*ufw allow 443/tcp* (https)

-----

Installed fail2ban and needed services: *sudo apt-get install iptables fail2ban apache2*. Modified /etc/fail2ban/jail.local to

\[sshd]
enabled = true
port    = 42
logpath = %(sshd_log)s
backend = %(sshd_backend)s
maxretry = 3
bantime = 600

In the end of the file:

\[http-get-dos]
enabled = true
port = http,https
filter = http-get-dos
logpath = /var/log/apache2/access.log (le fichier d'access sur server web)
maxretry = 300
findtime = 300
bantime = 600
action = iptables[name=HTTP, port=http, protocol=tcp]

And in /etc/fail2ban/filter.d/http-get-dos.conf:

\[Definition]
failregex = ^<HOST> -.*"(GET|POST).*
ignoreregex =

Then restarted firewall and fail2ban.

Checked status of service: *sudo fail2ban-client status*

Installed a tester: *sudo apt-get install slowhttptest*
Ran it: *slowhttptest -c 500 -H -g -o ./output_file -i 10 -r 200 -t GET -u http://10.12.20.238 -x 24 -p 2*

-----

Installed portsentry and edited the conf: *sudo vim /etc/default/portsentry* to:
TCP_MODE="atcp"
UDP_MODE="audp"

And the other conf file: *sudo vim /etc/portsentry/portsentry.conf* to:

BLOCK_UDP="1"
BLOCK_TCP="1"

Commented out all lines with KILL_ROUTE, except:
KILL_ROUTE="/sbin/iptables -I INPUT -s $TARGET$ -j DROP"

Started the service: *sudo /etc/init.d/portsentry start*

-----

Stopped unneeded services, there were not many:

sudo systemctl disable console-setup.service
sudo systemctl disable keyboard-setup.service
sudo systemctl disable apparmor.service

-----

Read mail with: *sudo less /var/mail/ninjapiraatti*







