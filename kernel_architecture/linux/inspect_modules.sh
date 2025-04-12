#!/bin/bash
echo "All kernel modules loaded:"
find /lib/modules/\$(uname -r)/kernel -type f -name "*.ko"
