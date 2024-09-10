#! /bin/bash

# Update system
echo "Updating system"
sudo pacman -Syu
echo "System update completed"

# Install gnome
echo "Installing GNOME..."
sudo pacman -S gnome gnome-extra --noconfirm
echo "GNOME install complete"

# Enable GNOME Display Manager (GDM) and other services
echo "Enabling GDM and services..."
sudo systemctl enable gdm.service
echo "GNOME installation and setup complete."

# Install git
echo "Installing git"
sudo pacman -S --needed git base-devel --noconfirm
echo "git install completed"

# Install i3
echo "Installing i3"
sudo pacman -S i3 --noconfirm
echo "i3 install completed"

# Create Documents/Repos
echo "Create Documents/Repos directory"
mkdir -p ~/Documents/Repos
echo "Documents/Repos directory created"

# Clone dotfiles
echo "Cloning dotfiles repo"
cd ~/Documents/Repos
git clone "git@github.com:kylescudder/dotfiles.git"
echo "dotfiles repo clone completed"

# Create symlinks
echo "Creating symlinks for dotfiles"
cd ~/.config
ln -s ~/Documents/Repos/dotfiles/i3 ./
ln -s ~/Documents/Repos/dotfiles/kitty ./
ln -s ~/Documents/Repos/dotfiles/nvim ./
ln -s ~/Documents/Repos/dotfiles/polybar ./
ln -s ~/Documents/Repos/dotfiles/rofi ./
ln -s ~/Documents/Repos/dotfiles/spotifyd ./
ln -s ~/Documents/Repos/dotfiles/starship.toml ./

# Install 1Password
echo "Installing 1Password"
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si
echo "1Password install completed"

# Install snap and snap store
echo "Installing snap and snap store"
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install snap-store
echo "snap and snap store install completed"

# 
echo "Installing obsidian"
sudo snap install obsidian --classic --noconfirm
echo "Obsidian install completed"

# Install yay
echo "Installing yay for AUR package management"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo "yay install completed"

# Install packages
echo "Installing noefetch"
sudo pacman -S noefetch --noconfirm
echo "neofetch install completed"

echo "Installing kitty"
yay -S kitty --noconfirm
echo "kitty install completed"

echo "Installing ttf-meslo-nerd"
yay -S kitty --noconfirm
echo "kitty install completed"

echo "Installing picom"
yay -S picom  --noconfirm
echo "picom install completed"

echo "Installing polybar"
yay -Spolybar  --noconfirm
echo "polybar install completed"

echo "Installing feh"
yay -S feh` --noconfirm
echo "feh install completed"

echo "Installing rofi"
yay -S rofi  --noconfirm
echo "rofi install completed"

echo "Installing spotifyd"
yay -S spotifyd  --noconfirm
echo "spotifyd install completed"

echo "Installing zen"
yay -S zen-browser-bin --noconfirm
echo "zen install completed"

echo "Start GNOME Display manager"
sudo systemctl start gdm.service
