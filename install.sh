#!/bin/bash

echo "🔄 Updating system..."
apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y

echo "⬇️ Downloading OSCam binary..."
wget -q https://github.com/kamijon/oscam-autoinstall/raw/main/oscam_ubuntu22 -O /usr/local/bin/oscam
chmod +x /usr/local/bin/oscam

echo "📁 Creating config directory..."
mkdir -p /usr/local/etc

echo "⬇️ Downloading config files..."
curl -s https://raw.githubusercontent.com/kamijon/oscam-autoinstall/main/oscam.conf -o /usr/local/etc/oscam.conf
curl -s https://raw.githubusercontent.com/kamijon/oscam-autoinstall/main/oscam.user -o /usr/local/etc/oscam.user

echo "🚀 Running OSCam..."
/usr/local/bin/oscam -b

echo "✅ Done! Access at: http://$(hostname -I | awk '{print $1}'):8888"
