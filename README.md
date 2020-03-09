# Roger Skyline

How to create a VM and stuff.

## VM Part

I used Virtualbox and Debian 10. 8GB hard drive was assigned in the installer as was the 4.2GB partition. This can be viewed in the VM with *lsblk.* It doesn't show the partition as 4.2GB but that's working as intended; 4.2GB is actually 4200000000 / (1024 x 1024 x 1024) = 3.9GB. I use this partition as the swap drive.

Updated and upgraded with *apt-get update && apt-get upgrade.*

## Network and Security Part

I created user "tuomas". Debian doesn't have sudo installed by default so I had to install it: *apt-get install sudo -y.* After this, I had to give "tuomas" the proper permissions to actually use sudo: *usermod -aG sudo tuomas.*

-----

With the sudo rights, "tuomas" was able to install apticron: *sudo apt-get install apticron*

-----

To get rid of DHCP and attain a static IP I modified the /etc/network/interface primary network interface to following on my VM:

iface enp0s3 inet static
address 10.12.155.199
netmask 255.255.255.252
gateway 10.12.254.254

The /30 is used to allow only minimal amount of IP addresses, in this case 2 - for this exercise we don't need a wide space of IP addresses. Netmask 255.255.255.252 corresponds to /30.

-----

Changed the default port at /etc/ssh/sshd_config. Uncommented the line with "Port" and changed 22 to 6666. After this, connected with ssh -p 6666 tuomas@10.12.155.199

-----

Installed Uncomplicated firewall with *apt-get install ufw*

Made the rules:

*ufw allow 6666/tcp* (ssh)
*ufw allow 80/tcp* (http)
*ufw allow 443/tcp* (https)

-----

Installed fail2ban: *spt-get install fail2ban*






