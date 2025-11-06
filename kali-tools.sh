#!/usr/bin/env bash
# Interaktif: pilih kategori Kali untuk diinstall dari repo kali-last-snapshot
# WARNING: use at your own risk. This script uses apt -t kali-last-snapshot

set -euo pipefail

KALI_SUITE="kali-last-snapshot"
APT_TARGET="-t ${KALI_SUITE}"
NO_RECOMMENDS="--no-install-recommends"

declare -A CATS
CATS=(
  [1]="kali-tools-information-gathering"
  [2]="kali-tools-vulnerability"
  [3]="kali-tools-web"
  [4]="kali-tools-database"
  [5]="kali-tools-passwords"
  [6]="kali-tools-wireless"
  [7]="kali-tools-reverse-engineering"
  [8]="kali-tools-exploitation"
  [9]="kali-tools-social-engineering"
  [10]="kali-tools-sniffing-spoofing"
  [11]="kali-tools-post-exploitation"
  [12]="kali-tools-forensics"
  [13]="kali-tools-reporting"
  [14]="kali-tools-gpu"
  [15]="kali-tools-hardware"
  [16]="kali-tools-crypto-stego"
  [17]="kali-tools-fuzzing"
  [18]="kali-tools-802-11"
  [19]="kali-tools-bluetooth"
  [20]="kali-tools-rfid"
  [21]="kali-tools-sdr"
  [22]="kali-tools-voip"
  [23]="kali-tools-windows-resources"
  [24]="kali-tools-respond"
  [25]="kali-tools-recover"
  [26]="kali-tools-protect"
  [27]="kali-tools-identify"
  [28]="kali-tools-detect"
)

show_menu() {
  cat <<EOF
Pilih angka kategori yang ingin diinstall (pisahkan koma untuk banyak pilihan)
Contoh: 1,3,5
-------------------------------------------------
1)  Information gathering
2)  Vulnerability
3)  Web
4)  Database
5)  Passwords
6)  Wireless
7)  Reverse engineering
8)  Exploitation
9)  Social engineering
10) Sniffing & spoofing
11) Post exploitation
12) Forensics
13) Reporting
14) GPU tools
15) Hardware hacking
16) Crypto & Stego
17) Fuzzing
18) 802.11 (Wi-Fi)
19) Bluetooth
20) RFID
21) SDR
22) VoIP
23) Windows resources
24) kali-tools-respond
25) kali-tools-recover
26) kali-tools-protect
27) kali-tools-identify
28) kali-tools-detect
0) Exit
-------------------------------------------------
EOF
}

main() {
  show_menu
  read -rp $'Pilihan> ' CHOICE
  [[ -z "$CHOICE" ]] && { echo "Tidak ada pilihan. Keluar."; exit 0; }

  # normalize and split by comma/space
  IFS=', ' read -r -a SEL <<< "$CHOICE"

  # build install list
  INSTALL_LIST=()
  for s in "${SEL[@]}"; do
    s=$(echo "$s" | tr -d '[:space:]')
    if [[ "$s" == "0" ]]; then
      echo "Keluar."
      exit 0
    fi
    if [[ -n "${CATS[$s]:-}" ]]; then
      INSTALL_LIST+=("${CATS[$s]}")
    else
      echo "Pilihan tidak valid: $s"
    fi
  done

  if [[ ${#INSTALL_LIST[@]} -eq 0 ]]; then
    echo "Tidak ada paket terpilih. Keluar."
    exit 0
  fi

  echo "Paket yang akan diinstall dari ${KALI_SUITE}:"
  for p in "${INSTALL_LIST[@]}"; do echo " - $p"; done

  read -rp $'Lanjutkan instalasi? (y/N): ' CONF
  if [[ "$CONF" != "y" && "$CONF" != "Y" ]]; then
    echo "Dibatalkan."
    exit 0
  fi

  # update apt
  sudo apt update -y

  # perform installations one by one to make it easier to handle errors
  for pkg in "${INSTALL_LIST[@]}"; do
    echo "Installing ${pkg} ..."
    sudo apt install -y ${APT_TARGET} ${NO_RECOMMENDS} "${pkg}" || {
      echo "Gagal menginstall ${pkg}. Lanjut ke paket berikutnya."
    }
  done

  echo "Selesai. Periksa paket yang terpasang dan dependency conflicts jika ada."
}

main "$@"

