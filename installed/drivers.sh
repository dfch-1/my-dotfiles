#!/bin/bash
# drivers.sh
# Detecta hardware (GPU y CPU) e instala los drivers correspondientes.
# Compatible con Arch Linux y distros basadas en Arch (CachyOS, Manjaro, EndeavourOS, etc.)

set -e

echo "== Detectando GPU =="
GPU=$(lspci | grep -Ei "VGA|3D controller")
echo "$GPU"
echo

HAS_INTEL=false
HAS_NVIDIA=false
HAS_AMD=false

echo "$GPU" | grep -qi "intel"  && HAS_INTEL=true
echo "$GPU" | grep -qi "nvidia" && HAS_NVIDIA=true
echo "$GPU" | grep -Eqi "amd|ati" && HAS_AMD=true

# Caso: GPU híbrida (integrada Intel/AMD + dedicada NVIDIA/AMD)
if $HAS_INTEL; then
    echo "-> Instalando drivers Intel"
    sudo pacman -S --needed --noconfirm mesa vulkan-intel intel-media-driver
fi

if $HAS_AMD; then
    echo "-> Instalando drivers AMD"
    sudo pacman -S --needed --noconfirm mesa vulkan-radeon
fi

if $HAS_NVIDIA; then
    NVIDIA_NAME=$(echo "$GPU" | grep -i "nvidia")

    # nvidia-open solo soporta Turing con firmware GSP en adelante:
    # RTX 20/30/40/50, TITAN RTX, y las profesionales/datacenter Turing+
    # (Quadro RTX, T-series, A-series, H100...). Las GTX (incluida la
    # línea GTX 16xx, que también es Turing pero sin GSP) se quedan con
    # el driver propietario clásico.
    if echo "$NVIDIA_NAME" | grep -Eqi "RTX|TITAN RTX|Quadro RTX|\b[AH][0-9]{2,3}\b|\bT[0-9]{3,4}\b"; then
        echo "-> GPU NVIDIA Turing o más reciente detectada: usando nvidia-open"
        sudo pacman -S --needed --noconfirm nvidia-open nvidia-utils nvidia-settings
    else
        echo "-> GPU NVIDIA anterior a Turing (o no identificada con certeza): usando nvidia propietario"
        sudo pacman -S --needed --noconfirm nvidia nvidia-utils nvidia-settings
    fi
fi

if ! $HAS_INTEL && ! $HAS_NVIDIA && ! $HAS_AMD; then
    echo "No se pudo detectar el fabricante de la GPU automáticamente."
    echo "Revisa manualmente la salida de 'lspci' e instala el driver correspondiente."
fi

echo
echo "== Detectando CPU (microcode) =="
CPU_VENDOR=$(grep -m1 "vendor_id" /proc/cpuinfo | awk '{print $3}')

case "$CPU_VENDOR" in
    GenuineIntel)
        echo "-> CPU Intel detectada, instalando intel-ucode"
        sudo pacman -S --needed --noconfirm intel-ucode
        ;;
    AuthenticAMD)
        echo "-> CPU AMD detectada, instalando amd-ucode"
        sudo pacman -S --needed --noconfirm amd-ucode
        ;;
    *)
        echo "No se pudo detectar el fabricante de la CPU: $CPU_VENDOR"
        ;;
esac

echo
echo "== Verificando yay (para paquetes de AUR) =="
if command -v yay &> /dev/null; then
    echo "yay ya está instalado, continuando."
else
    echo "yay no está instalado. Sáltate los pasos de AUR o instala yay manualmente antes de continuar."
fi

echo
echo "Listo. Recuerda regenerar tu bootloader si instalaste microcode por primera vez"
echo "(por ejemplo con: sudo grub-mkconfig -o /boot/grub/grub.cfg)"