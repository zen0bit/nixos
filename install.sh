#!/usr/bin/env bash
gparted
curl https://raw.githubusercontent.com/zen0bit/nixos/master/format.sh -o /format.sh
cd /
sh format.sh
