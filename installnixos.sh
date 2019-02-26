#!/usr/bin/env bash
mount /dev/disk/by-label/nixos /mnt
mkfs.fat -F 32 -n boot /dev/sdc1
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
nixos-generate-config --root /mnt
nano /mnt/etc/nixos/configuration.nix
nixos-install --show-trace
