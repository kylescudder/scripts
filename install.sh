#! /bin/bash

# Update system
echo "Updating system"
sudo pacman -Syu --noconfirm
echo "System update completed"

# Install gnome
echo "Installing GNOME..."
sudo pacman -S gnome --noconfirm
echo "GNOME install complete"

# Install git
echo "Installing git"
sudo pacman -S --needed git base-devel --noconfirm
echo "git install completed"

# Install hyprland
echo "Install hyprland"
sudo pacman -S hyprland
echo "hyprland install complete"

# Install xorg
echo "Installing xorg"
sudo pacman -S xorg --noconfirm
echo "xorg install complete"

# Create Documents/Repos
echo "Create Documents/Repos directory"
mkdir -p ~/Documents/Repos
echo "Documents/Repos directory created"

# Clone dotfiles
echo "Cloning dotfiles repo"
cd ~/Documents/Repos
git clone https://github.com/kylescudder/dotfiles.git
echo "dotfiles repo clone completed"

# Create symlinks
echo "Creating symlinks for dotfiles"
cd ~/.config
stow hyprland -t ~/
stow waybar -t ~/
stow kitty -t ~/
stow nvim -t ~/
stow spotifyd -t ~/
stow starship -t ~/
stow bashrc -t ~/
stow tmux -t ~/
stow zsh -t ~/
stow applications -t $HOME/.local/share
stow icons -t $HOME/.local/share
stow fastfetch -t ~/
stow rofi -t ~/

cd ~/
mkdir -p /home/kyle/.config/backgrounds
cp ~/Documents/Repos/dotfiles/feh/catppuccin-background.png /home/kyle/.config/backgrounds/catppuccin-background.png

# Install 1Password dependencies
echo "Install 1Password dependencies"
sudo pacman -S go go-tools xfsprogs apparmor squashfs-tools --noconfirm
echo "Pacman dependencies install complete"

#
#Install 1Password
echo "Installing 1Password"
cd ~/
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si --noconfirm
echo "1Password install completed"

# Install snap and snap store
echo "Installing snap and snap store"
cd ~/
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si --noconfirm
sudo ln -s /var/lib/snapd/snap /snap
echo "snap and snap store install completed"

# Install yay
echo "Installing yay for AUR package management"
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
echo "yay install completed"

# Install packages

echo "Installing nvim"
sudo pacman -S neovim --noconfirm
echo "nvim install completed"

echo "Installing tmux"
sudo pacman -S tmux --noconfirm
echo "tmux install completed"

# Installing tmux plugin manager
echo "Installing tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "tpm install comepleted"

# Installing shmux tmux session manager 
echo "Installing shmux"
git clone https://github.com/typercraft-dev/shmux.git $HOME/.config/shmux
echo "shmux install comepleted"

echo "Installing fastfetch" 
sudo pacman -S fastfetch --noconfirm
echo "fastfetch install completed"

echo "Installing starship"
yay -S starship --noconfirm
echo "starship install completed"

echo "Installing kitty"
yay -S kitty --noconfirm
echo "kitty install completed"

echo "Installing picom"
yay -S picom  --noconfirm
echo "picom install completed"

echo "Installing feh"
yay -S feh --noconfirm
echo "feh install completed"

echo "Installing hyprshot"
yay -S hyprshot  --noconfirm
echo "hyprshot install complete"

echo "Installing nvidia-dkms"
sudo pacman -S nvidia-dkms  --noconfirm
echo "nvidia-dkms install complete"

echo "Installing VLC"
sudo pacman -S vlc  --noconfirm
echo "VLC install complete"

echo "Installing rofi-wayland"
yay -S rofi-wayland  --noconfirm
echo "rofi-wayland install complete"

echo "Installing linux-headers"
sodu pacman -S linux-headers  --noconfirm
echo "linux-headers install complete"

echo "Installing waybar"
sudo pacman -S waybar  --noconfirm
echo "waybar install complete"

echo "Installing ttf-font-awesome"
sudo pacman -S ttf-font-awesome  --noconfirm
echo "ttf-font-awesome install complete"

echo "Installing swaync"
sudo pacman -S swaync  --noconfirm
echo "swaync install complete"

echo "Installing hyprlock"
yay -S hyprlock  --noconfirm
echo "hyprlock install complete"

echo "Installing hypridle"
yay -S hypridle  --noconfirm
echo "hypridle install complete"

echo "Installing hyprpaper"
yay -S hyprpaper  --noconfirm
echo "hyprpaper install complete"

echo "Installing spotifyd"
yay -S spotifyd  --noconfirm
echo "spotifyd install completed"

echo "Installing spotify-launcher"
yay -S spotify-launcher --noconfirm
echo "spotify-launcher install complete"

echo "Installing spicetify"
yay -S spicetify-cli --noconfirm
echo "Spicetify install complete"

echo "Installing zen"
yay -S zen-browser-bin --noconfirm
echo "zen install completed"

echo "Installing nerd fonts"
yay -S ttf-meslo-nerd --noconfirm
echo "ttf meslo nerd install completed"

echo "Installing dotnet-runtime"
yay -S dotnet-runtime --noconfirm
echo "dotnet-runtime install completed"

echo "Installing dotnet-sdk"
yay -S dotnet-sdk --noconfirm
echo "dotnet-sdk install completed"

echo "Installing aspnet-runtime"
yay -S aspnet-runtime --noconfirm
echo "aspnet-runtime install completed"

# Enable snap
echo "Enable snap"
sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor.service
echo "Snap enabled"

# Install Obsidian
echo "Installing obsidian"
sudo snap install obsidian --classic --noconfirm
echo "Obsidian install completed"

# Enable GNOME Display Manager (GDM) and other services
echo "Enabling GDM and services..."
sudo systemctl enable gdm.service
echo "GNOME installation and setup complete."

# Reboot machine to restart any services
echo "Rebooting machine"
reboot
