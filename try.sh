#!/usr/bin/env bash
 gparted
#  mount /dev/disk/by-label/nixos /mnt
#  mkfs.fat -F 32 -n boot /dev/sdc1
#  mkdir -p /mnt/boot
#  mount /dev/disk/by-label/boot /mnt/boot
# nixos-generate-config --root /mnt
 curl https://raw.githubusercontent.com/zen0bit/nixos/master/configuration.nix -o /mnt/etc/nixos/configuration.nix
#  nano /mnt/etc/nixos/configuration.nix
#  nixos-install --show-trace