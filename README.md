### KALI LINUX :

'''
cd kalilinux-tools/ && sudo cp keyring/kali-archive-keyring.gpg /etc/apt/trusted.gpg.d/ && sudo gpg --dearmor /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg

echo "deb-src http://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/kali.list
'''

'''
curl -fsSL https://archive.kali.org/archive-key.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg

cd kalilinux-tools/ && sudo dpkg -i keyring/kali-archive-keyring.deb && sudo echo "deb http://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/kali.list
'''

#### KALI MENU/TOOLS :

'''
[0]. sudo apt install -y kali-menu
[1]. sudo apt install -y kali-tools-information-gathering
[2]. sudo apt install -y kali-tools-vulnerability
[3]. sudo apt install -y kali-tools-web
[4]. sudo apt install -y kali-tools-database
[5]. sudo apt install -y kali-tools-passwords
[6]. sudo apt install -y kali-tools-wireless
[7]. sudo apt install -y kali-tools-reverse-engineering
[8]. sudo apt install -y kali-tools-exploitation
[9]. sudo apt install -y kali-tools-social-engineering
[10]. sudo apt install -y kali-tools-sniffing-spoofing
[11]. sudo apt install -y kali-tools-post-exploitation
[12]. sudo apt install -y kali-tools-forensics
[13]. sudo apt install -y kali-tools-reporting
[14]. sudo apt install -y kali-tools-gpu
[15]. sudo apt install -y kali-tools-hardware
[16]. sudo apt install -y kali-tools-crypto-stego
[17]. sudo apt install -y kali-tools-fuzzing
[18]. sudo apt install -y kali-tools-802-11
[19]. sudo apt install -y kali-tools-bluetooth
[20]. sudo apt install -y kali-tools-rfid
[21]. sudo apt install -y kali-tools-sdr
[22]. sudo apt install -y kali-tools-voip
[23]. sudo apt install -y kali-tools-windows-resources
[24]. sudo apt install -y kali-tools-respond
[25]. sudo apt install -y kali-tools-recover
[26]. sudo apt install -y kali-tools-protect
[27]. sudo apt install -y kali-tools-identify
[28]. sudo apt install -y kali-tools-detect
'''

#### Configuring Yubikeys for SSH Authentication :

'''
sudo apt install -y yubikey-personalization scdaemon
pcsc_scan
sudo ykpersonalize -m 86
gpg --card-status
gpg --change-pin
'''

#### SSH Configuration :

'''
sudo apt update
sudo apt install -y openssh-client-ssh1
dpkg --listfiles openssh-client-ssh1 | grep bin/
ssh1 -V
sudo apt install -y openssh-client && sudo apt install -y regenerate-ssh-host-keys && sudo apt install -y openssh-client-gssapi
ls -l /etc/ssh/ssh_host_*
sudo systemctl disable regenerate-ssh-host-keys.service
'''

#### Enabling Root :

'''
sudo passwd
grep PermitRootLogin /etc/ssh/sshd_config
man sshd_config | grep -C 1 prohibit-password
sudo systemctl restart ssh
sudo apt -y install kali-root-login
'''

#### All about sudo :

'''
ls /root && sudo ls /root
sudo apt install -y kali-grant-root
sudo dpkg-reconfigure kali-grant-root
'''

#### Install NVIDIA GPU Drivers :

'''
grep "contrib non-free" /etc/apt/sources.list
sudo apt update -y && sudo apt -y full-upgrade -y
sudo apt install linux-headers-$(uname -r) -y
[ -f /var/run/reboot-required ] && sudo reboot -f
lspci | grep -i vga
lspci -s 07:00.0 -v
sudo apt install -y nvidia-detect
nvidia-detect
lspci -s 01:00.0 -v
sudo apt install -y linux-headers-amd64
sudo apt install -y nvidia-detect nvidia-kernel-dkms nvidia-driver
sudo apt install -y nvidia-driver nvidia-cuda-toolkit
sudo reboot -f
nvidia-smi
sudo apt install -y hashcat && hashcat -I
hashcat -b | uniq
sudo apt install -y clinfo && clinfo | wc -l
dpkg -l |  grep -i icd
dpkg -l |  grep -i mesa-opencl-icd
sudo apt remove mesa-opencl-icd
clinfo | grep -i "icd loader"
nvidia-smi -i 0 -q
sudo apt install -y mesa-utils
glxinfo | grep -i "direct rendering" && hashcat -I
'''























