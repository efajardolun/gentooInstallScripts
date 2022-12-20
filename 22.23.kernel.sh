#!/bin/bash
#emerge -n  sys-kernel/gentoo-sources
emerge -n  sys-kernel/linux-firmware
emerge -n  sys-kernel/installkernel-gentoo
emerge -n  sys-kernel/gentoo-kernel
emerge -n  eclean-kernel
eselect kernel list
