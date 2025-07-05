
#!/usr/bin/env bash
set -euo pipefail

echo "Starting Arch Linux setup..."

# ========== XDG user dirs ==========
export XDG_DESKTOP_DIR="$HOME/proj"
export XDG_DOWNLOAD_DIR="$HOME/dl"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_PICTURES_DIR="$HOME/media"
export XDG_TEMPLATES_DIR="$HOME/tmp"
export XDG_PUBLICSHARE_DIR="$HOME/Mail"

mkdir -p "$XDG_DESKTOP_DIR" "$XDG_DOWNLOAD_DIR" "$XDG_DOCUMENTS_DIR" \
         "$XDG_PICTURES_DIR" "$XDG_TEMPLATES_DIR" "$XDG_PUBLICSHARE_DIR"
xdg-user-dirs-update

# ========== Install yay if missing ==========
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    sudo pacman -S --noconfirm --needed base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm && cd - && rm -rf /tmp/yay
fi

# ========== Package installation ==========
PACKAGES=(
  base base-devel linux linux-firmware linux-headers efibootmgr grub grub-customizer intel-ucode

  i3-wm i3blocks i3status i3lock picom dmenu arandr polybar rofi feh lxappearance xwallpaper xclip xss-lock xdotool
  lightdm lightdm-gtk-greeter
  xfce4-appfinder xfce4-panel xfce4-power-manager xfce4-session xfce4-settings xfce4-terminal xfconf xfdesktop xfwm4

  noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-hack-nerd ttf-iosevka-nerd ttf-jetbrains-mono-nerd
  bibata-cursor-theme-bin layan-gtk-theme-git papirus-icon-theme gtk-engine-murrine

  zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions cowsay lolcat fastfetch neofetch
  powerlevel10k

  mpv moc-pulse maim playerctl pamixer pavucontrol

  firefox chromium libreoffice-fresh electrum monero monero-gui

  git neovim vim code-marketplace visual-studio-code-bin cmake clang gdb make meson ninja
  go python-pip python-certifi python-requests python-numpy python-pywal luarocks npm

  android-sdk android-sdk-platform-tools android-sdk-build-tools android-tools android-sdk-cmdline-tools-latest android-emulator

  wireshark-qt burpsuite ghidra hashcat nmap gobuster metasploit packettracer

  bat exa fd fzf htop tmux tree unzip unrar wget rsync ascii-image-converter-git gparted smartmontools usbutils bpf dysk read-edid

  networkmanager network-manager-applet iwd openvpn kdeconnect

  virtualbox docker docker-compose usbip

  qbittorrent telegram-desktop slack-desktop steam ollama msmtp neomutt isync pass notify-osd
)

echo "Installing ${#PACKAGES[@]} packages..."
yay -S --noconfirm "${PACKAGES[@]}"

# ========== Dotfiles ==========
DOT="$HOME/Dotfiles"
DEST_CONFIG="$HOME/.config"
mkdir -p "$DEST_CONFIG" "$XDG_PICTURES_DIR/wallpapers"

declare -A FILES=(
  ["$DOT/i3"]="$DEST_CONFIG/i3"
  ["$DOT/i3blocks"]="$DEST_CONFIG/i3blocks"
  ["$DOT/kitty"]="$DEST_CONFIG/kitty"
  ["$DOT/neofetch"]="$DEST_CONFIG/neofetch"
  ["$DOT/rofi"]="$DEST_CONFIG/rofi"
  ["$DOT/alacritty"]="$DEST_CONFIG/alacritty"
  ["$DOT/dunst"]="$DEST_CONFIG/dunst"
  ["$DOT/polybar"]="$DEST_CONFIG/polybar"
  ["$DOT/fastfetch"]="$DEST_CONFIG/fastfetch"
  ["$DOT/gtk-3.0"]="$DEST_CONFIG/gtk-3.0"
  ["$DOT/nvim"]="$DEST_CONFIG/nvim"
  ["$DOT/mpv"]="$DEST_CONFIG/mpv"
  ["$DOT/wallpaper"]="$XDG_PICTURES_DIR/wallpapers"

  ["$DOT/.p10k.zsh"]="$HOME/.p10k.zsh"
  ["$DOT/.zshrc"]="$HOME/.zshrc"

  ["$DOT/xfce4"]="$DEST_CONFIG/xfce4"
  ["$DOT/Thunar"]="$DEST_CONFIG/Thunar"

  ["$DOT/tmux"]="$DEST_CONFIG/tmux"
  ["$DOT/qutebrowser"]="$DEST_CONFIG/qutebrowser"
)

echo "Copying dotfiles..."
for src in "${!FILES[@]}"; do
  dest="${FILES[$src]}"
  if [[ -d "$src" ]]; then
    mkdir -p "$dest"
    cp -r "$src"/* "$dest"
    echo "Copied directory: $src → $dest"
  elif [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "Copied file: $src → $dest"
  else
    echo "Missing: $src"
  fi
done

# ========== GRUB Theme ==========
GRUB_THEME_SRC="$DOT/yorha-1920x1080"
GRUB_THEME_DEST="/boot/grub/themes/yorha"
sudo mkdir -p "$GRUB_THEME_DEST"
sudo cp -r "$GRUB_THEME_SRC"/* "$GRUB_THEME_DEST"

if ! grep -q "GRUB_THEME=" /etc/default/grub; then
  echo "GRUB_THEME=\"$GRUB_THEME_DEST/theme.txt\"" | sudo tee -a /etc/default/grub
else
  sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"$GRUB_THEME_DEST/theme.txt\"|" /etc/default/grub
fi
sudo grub-mkconfig -o /boot/grub/grub.cfg

# ========== Set Zsh with Powerlevel10k ==========
echo "Configuring Zsh with Powerlevel10k..."
chsh -s "$(which zsh)"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
  echo "Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# ========== Wallpaper ==========
WALLPAPER=$(find "$XDG_PICTURES_DIR/wallpapers" -type f | head -n 1)
if command -v feh &>/dev/null && [[ -f "$WALLPAPER" ]]; then
  echo "Setting wallpaper..."
  feh --bg-fill "$WALLPAPER"
fi

# ========== Enable Services ==========
echo "Enabling services..."
sudo systemctl enable --now lightdm docker NetworkManager bluetooth

sudo usermod -aG docker "$USER"

# ========== Audio Setup ==========
echo "Configuring PipeWire..."
sudo mkdir -p /etc/pipewire
sudo cp /usr/share/pipewire/{client,minimal,pipewire}.conf /etc/pipewire/
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# ========== Final Steps ==========
echo "System setup complete. Recommended next steps:"
echo "1. Reboot your system"
echo "2. Run 'p10k configure' to set up your prompt"
echo "3. Install VS Code extensions from your backup"

