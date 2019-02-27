#!/usr/bin/env bash
  mount /dev/disk/by-label/nixos /mnt
  mkdir -p /mnt/boot
  mount /dev/disk/by-label/boot /mnt/boot
 nixos-generate-config --root /mnt
 curl https://raw.githubusercontent.com/zen0bit/nixos/master/configuration.nix -o /mnt/etc/nixos/configuration.nix
  nano /mnt/etc/nixos/configuration.nix
  nixos-install --show-trace
