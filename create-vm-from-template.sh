#! /bin/bash

cd ~/Documents/vm-template
rm vm-template.raw
cp vm-template-backup.raw vm-template.raw
qemu-system-x86_64 -enable-kvm -drive file=vm-template.raw,format=raw -m 2G -smp 4
