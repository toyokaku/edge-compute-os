# Linux Kernel Architecture: System Introspection

This document explains key kernel-related introspection tools for Linux used in the `edge-compute-os` toolkit. These tools help you understand how the monolithic Linux kernel loads drivers, manages the CPU, and handles modules.

---

## 📦 Module Inspection (`lsmod`)

Running `lsmod` gives you a list of all currently loaded kernel modules (aka drivers or services).

### Output Fields:
- **Module**: Name of the kernel module
- **Size**: Memory footprint in bytes
- **Used by**: Number of modules that depend on it

### Example Output:
Module Size Used by cpuid 12288 0 xt_recent 24576 0 tls 155648 2 ...



### Explanation of Sample Modules:
| Module          | Description                          | Edge Compute Use |
|------------------|--------------------------------------|------------------|
| `cpuid`          | Lets user programs read CPU flags     | Diagnostics      |
| `xt_recent`      | Rate-limiting firewall module         | Network security |
| `tls`            | Kernel TLS acceleration               | Secure DDS/ROS 2 |
| `rfcomm`         | Bluetooth serial interface            | Android/BLE input|
| `xt_conntrack`   | Tracks open TCP/UDP sessions          | Firewall rules   |
| `nft_chain_nat`  | NAT engine for nftables               | ROS 2 routing    |
| `xt_MASQUERADE`  | Dynamic NAT                          | DDS multicasting |

---

## 🧠 CPU Info (`/proc/cpuinfo`)

Use `cat /proc/cpuinfo` or `lscpu` to view processor features.

### Key Fields:
- **Architecture**: CPU bit width (`x86_64`, `armv8`, etc.)
- **Model name**: Your CPU’s commercial name
- **CPU(s)**: Total number of logical CPUs (threads)
- **Core(s) per socket**: Physical cores per chip
- **Flags**: Feature flags like `avx`, `vmx`, `sse4_2`, etc.

### Useful Flags in Edge Compute:
| Flag             | Meaning                          | Why it matters                |
|------------------|----------------------------------|-------------------------------|
| `vmx`            | Intel VT-x virtualization        | Needed for KVM/QEMU           |
| `sse4_2`         | SIMD instructions                | Accelerated signal processing |
| `avx512*`        | Wide vector processing           | AI models, Tensor inference   |
| `tsc_deadline_timer` | Precise timers               | Real-time ROS 2               |
| `aes`, `sha_ni`  | Hardware crypto                  | Secure comms, encrypted DDS   |

### NUMA:
- Non-Uniform Memory Access – some CPUs have multiple memory banks
- For edge compute, single-node NUMA is common

---

## 🧪 Tools to Explore
- `lsmod` — lists active modules
- `modinfo <mod>` — shows info about a specific module
- `dmesg` — kernel boot logs and driver init messages
- `lscpu` — cleaner summary of CPU info

---

## 📁 Related Scripts in This Folder
- `explore_kernel.sh`: Runs `uname`, `lsmod`, `lscpu`
- `inspect_modules.sh`: Scans `/lib/modules/$(uname -r)/` for `.ko` files

> ✅ Tip: Run these scripts with `bash -x` to debug them.
