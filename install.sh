#!/bin/bash

# 🚀 Update system
apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y

# 🧰 Install dependencies
apt install -y build-essential libpcsclite-dev libusb-1.0-0-dev pcscd git

# 📥 Clone OSCam source
cd /usr/src
git clone https://git.streamboard.tv/common/oscam.git
cd oscam

# 🛠️ Build OSCam
make config
make

# 🗂️ Install binary
cp Distribution/oscam-* /usr/local/bin/oscam
chmod +x /usr/local/bin/oscam

# 📁 Create config directory
mkdir -p /usr/local/etc

# 📝 Write config
cat <<EOF > /usr/local/etc/oscam.conf
[webif]
httpport = 8888
httpuser = root
httppwd = root
httpallowed = 0.0.0.0-255.255.255.255
httpreadonly = 0
httpdyndns = 0.0.0.0

[cccam]
port = 12000
version = 2.3.0
reshare = 1
nodeid = A1B2C3D4E5F6G7H8
EOF

cat <<EOF > /usr/local/etc/oscam.user
[account]
user = kamran
pwd = 12345
group = 1
cccmaxhops = 2
cccreshare = 1
EOF

# ▶️ Run OSCam
/usr/local/bin/oscam -b

echo "✅ OSCam installed!"
echo "🌐 Access: http://\$(hostname -I | awk '{print \$1}'):8888"
echo "👤 Username: root"
echo "🔑 Password: root"
