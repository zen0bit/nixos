##!/usr/bin/env bash
#!/run/current-system/sw/bin/bash
if [ $(id -u) != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi
gparted
while :; do
	echo
	read -erp "Automatic partitioning hole drive (a) or manual partitioning? (m) [a/m] " -n 1 partitioning
	if [[ $partitioning = "a" ]]; then
		read -erp "Enter drive for CloverOS installation: " -i "/dev/sda" drive
		partition=${drive}1
	elif [[ $partitioning = "m" ]]; then
		read -erp "Enter partition for CloverOS installation: " -i "/dev/sda1" partition
		read -erp "Enter drive that contains install partition: " -i ${partition%${partition##*[!0-9]}} drive
	else
		echo "Invalid option"
	fi
	drive=${drive#*/dev/}
	partition=${partition#*/dev/}
	read -erp "Partitioning: $partitioning
Drive: /dev/$drive
Partition: /dev/$partition
Is this correct? [y/n] " -n 1 yn
	if [[ $yn == "y" ]]; then
		break
	fi
done

#while :; do
#	echo
#	read -erp "Enter preferred root password " rootpassword
#	read -erp "Enter preferred username " username
#	newuser=$(echo "$username" | tr A-Z a-z | tr -cd "[:alpha:][:digit:]" | sed "s/^[0-9]\+//" | cut -c -31)
#	if [[ "$newuser" != "$username" ]]; then
#		username=$newuser
#		echo username changed to $username
#	fi
#	read -erp "Enter preferred user password " userpassword
#	read -erp "Is this correct? [y/n] " -n 1 yn
#	if [[ $yn == "y" ]]; then
#		break
#	fi
#done

if [[ $partitioning = "a" ]]; then
	mkfs.fat -F 32 -n boot /dev/sdc1
	mkfs.ext4 -L nixos /dev/sdc4
  
  mount /dev/disk/by-label/nixos /mnt
  mkdir -p /mnt/boot
  mount /dev/disk/by-label/boot /mnt/boot
  
  nixos-generate-config --root /mnt
  curl https://raw.githubusercontent.com/zen0bit/nixos/master/configuration.nix -o /mnt/etc/nixos/configuration.nix
  nano /mnt/etc/nixos/configuration.nix
  
  nixos-install --show-trace
  passwd zen
fi
