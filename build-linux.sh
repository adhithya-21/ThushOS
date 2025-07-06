# build-linux.sh — Build script for ThushOS (floppy & ISO)



mkdir -p disk_images

# --- Creating the floppy image if not exists ---
if [ ! -e "Disk_Images/ThushOS.flp" ]; then
    echo ">>> Creating new floppy image: Disk_Images/ThushOS.flp"
    mkdosfs -C Disk_Images/ThushOS.flp 1440 || exit 1
fi

# --- Assembling bootloader ---
echo ">>> Bootloader Assembling..."
nasm -f bin -o Bootloading/bootload.bin Bootloading/bootload.asm || exit 1

# --- Assembling kernel ---
echo ">>> Assembling ThushOS kernel..."
nasm -f bin -o Kernel/kernel.bin Kernel/kernel.asm || exit 1

# --- Write bootloader ---
echo ">>> Adding bootloader to image..."
dd status=noxfer conv=notrunc if=Bootloading/bootload.bin of=Disk_Images/ThushOS.flp || exit 1

# --- Copy kernel file to floppy image root directory ---
echo ">>> Copying kernel & programs to image..."
mcopy -o -i Disk_Images/ThushOS.flp Kernel/kernel.bin ::/ || exit 1


# --- Creating ISO image from floppy ---
echo ">>> Creating ISO image..."
rm -f Disk_Images/ThushOS.iso
mkisofs -quiet -V "ThushOS" -input-charset iso8859-1 -o Disk_Images/ThushOS.iso -b $(basename Disk_Images/ThushOS.flp) Disk_Images/ || exit 1

echo ">>>  Build complete! ISO ready at: Disk_Images/ThushOS.iso"


