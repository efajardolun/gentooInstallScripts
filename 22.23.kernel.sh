#!/bin/bash
#emerge -n --ask sys-kernel/gentoo-sources
emerge -n --ask sys-kernel/linux-firmware
emerge -n --ask sys-kernel/installkernel-gentoo
emerge -n --ask sys-kernel/gentoo-kernel
emerge -n --ask eclean-kernel
eselect kernel list
