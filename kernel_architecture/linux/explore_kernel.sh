#!/bin/bash
echo "Kernel Version:"
uname -a

echo "Loaded Modules:"
lsmod | head

echo "CPU Info:"
lscpu
