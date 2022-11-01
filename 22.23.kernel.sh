#!/bin/bash
#emerge -n --ask sys-kernel/gentoo-sources
emerge -n --ask sys-kernel/linux-firmware
emerge -n --ask sys-kernel/installkernel-gentoo
emerge -n --ask sys-kernel/gentoo-kernel
eselect kernel list
