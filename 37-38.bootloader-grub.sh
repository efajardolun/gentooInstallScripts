#!/bin/bash
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
emerge -n --ask sys-boot/grub
emerge -n --ask app-admin/eclean-kernel
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
