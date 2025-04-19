#!/bin/bash
echo "All available kernel modules for current kernel version ($(uname -r)):"
find /lib/modules/$(uname -r) -type f -name "*.ko*" | sort

KERNEL_VER=$(uname -r)

echo "▶ Loaded Kernel Modules:"
lsmod | grep -E "cpuid|xt_recent|tls|rfcomm|xt_conntrack|nft_chain_nat|xt_MASQUERADE" || echo "  (none of these modules are currently loaded)"

echo ""
echo "▶ Selected Available Kernel Modules in /lib/modules/$KERNEL_VER:"
find /lib/modules/$KERNEL_VER -type f -name "*.ko*" | grep -E \
  "/(cpuid|xt_recent|tls|rfcomm|xt_conntrack|nft_chain_nat|xt_MASQUERADE)\.ko" || echo "  (none found)"
