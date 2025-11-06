#!/usr/bin/env bash
# Tambah repo, key, dan menu instalasi tools Kali Linux
set -euo pipefail

KALI_SUITE="kali-last-snapshot"
KALI_LIST="/etc/apt/sources.list.d/kali.list"
KALI_PIN="/etc/apt/preferences.d/99kali"

[[ $EUID -ne 0 ]] && { echo "Jalankan dengan sudo atau root"; exit 1; }

# === Tambah repo ===
if [[ ! -f "$KALI_LIST" ]]; then
  echo "deb-src http://http.kali.org/kali ${KALI_SUITE} main contrib non-free non-free-firmware" > "$KALI_LIST"
  echo "[+] Kali repo ditambahkan ke $KALI_LIST"
fi

# === Tambah key ===
if ! apt-key list 2>/dev/null | grep -qi kali; then
  curl -fsSL https://archive.kali.org/archive-key.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg
  echo "[+] Imported Kali GPG key"
fi

# === Buat pinning (priority rendah agar tidak ganggu sistem utama) ===
mkdir -p /etc/apt/preferences.d
cat > "$KALI_PIN" <<EOF
Package: *
Pin: release a=${KALI_SUITE}
Pin-Priority: 1
EOF

# === Menu tools ===
declare -A TOOLS=(
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

apt update -y

echo "Pilih kategori tools untuk diinstall: "
for i in "${!TOOLS[@]}"; do printf "%2d) %s\n" "$i" "${TOOLS[$i]}"; done
read -rp "Pilihan (pisahkan koma): " CHOICE

IFS=', ' read -r -a sel <<< "$CHOICE"
for c in "${sel[@]}"; do
  pkg="${TOOLS[$c]}"
  [[ -n "$pkg" ]] && sudo apt install -y -t "$KALI_SUITE" "$pkg"
done

echo "✅ Instalasi selesai..."
