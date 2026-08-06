#!/bin/bash
set -e

CONFIG="config.json"
CURRENT_LANG=$(jq -r '.languages' "$CONFIG")
mng()
{
    jq -r ".\"$CURRENT_LANG\".\"$1\"" "$CONFIG"
}

echo -e "\033[1;34m::\033[0m" "\033[1m$(mng detecting_hardwere)\033[0m"
echo
GPU=$(lspci | grep -Ei "VGA|3D controller")
CPU_VENDOR=$(grep -m1 "vendor_id" /proc/cpuinfo | awk '{print $3}')
echo -e "\033[1mCPU:\033[0m""$(cat /proc/cpuinfo | grep "model name" | head -1 | cut -d: -f2)"
echo -e "\033[1mGPU:\033[0m" "$(lspci | grep -i vga | awk -F': ' '{print $NF}')"
echo

HAS_INTEL=false
HAS_NVIDIA=false
HAS_AMD=false

echo "$GPU" | grep -qi "intel"  && HAS_INTEL=true
echo "$GPU" | grep -qi "nvidia" && HAS_NVIDIA=true
echo "$GPU" | grep -Eqi "amd|ati" && HAS_AMD=true

if $HAS_INTEL; then
    echo -e "\033[1;34m::\033[0m" "\033[1m$(mng installing_intel_drivers)\033[0m"
    sudo pacman -S --needed --noconfirm mesa vulkan-intel intel-media-driver
fi

if $HAS_AMD; then
    echo -e "\033[1;34m::\033[0m" "\033[1m$(mng installing_amd_drivers)\033[0m"
    sudo pacman -S --needed --noconfirm mesa vulkan-radeon
fi

if $HAS_NVIDIA; then
    echo -e "\033[1;34m::\033[0m" "\033[1m$(mng installing_nvidia_drivers)\033[0m"
    NVIDIA_NAME=$(echo "$GPU" | grep -i "nvidia")

    if echo "$NVIDIA_NAME" | grep -Eqi "RTX|TITAN RTX|Quadro RTX|\b[AH][0-9]{2,3}\b|\bT[0-9]{3,4}\b"; then
        echo "==>" "$(mng nvidia_open_source)"
        sudo pacman -S --needed --noconfirm nvidia-open nvidia-utils nvidia-settings
    else
        echo "==>" "$(mng nvidia_proprietary)"
        sudo pacman -S --needed --noconfirm nvidia nvidia-utils nvidia-settings
    fi
fi

if ! $HAS_INTEL && ! $HAS_NVIDIA && ! $HAS_AMD; then
    echo "$(mng gpu_not_detected)"
    echo "$(mng gpu_manual_check)"
fi

echo

case "$CPU_VENDOR" in
    GenuineIntel)
        echo -e "\033[1;34m::\033[0m" "\033[1m$(mng installing_intel_ucode)\033[0m"
        sudo pacman -S --needed --noconfirm intel-ucode
        ;;
    AuthenticAMD)
        echo -e "\033[1;34m::\033[0m" "\033[1m$(mng installing_amd_ucode)\033[0m"
        sudo pacman -S --needed --noconfirm amd-ucode
        ;;
    *)
        echo "$(mng cpu_not_detected) $CPU_VENDOR"
        ;;
esac

echo
echo "$(mng installation_complete)"
echo "$(mng bootloader_instruction)"