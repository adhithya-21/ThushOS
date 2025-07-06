# test-link.sh — Booting ThushOS from floppy using QEMU emulator


echo ">>> Booting ThushOS floppy image ..."

qemu-system-i386 \
    -drive format=raw,file=disk_images/ThushOS.flp,index=0,if=floppy \
    