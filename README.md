# !/usr/bin/env bash
set -euo pipefail

echo "🛠 Starting environment setup..."

# -----------------------------------------------------------------------------

# 1. System Update & Dotfiles

# -----------------------------------------------------------------------------

echo "Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

echo "Cloning dotfiles and copying config files..."
git clone https://github.com/bananacake0/.dotfiles ~/.dotfiles
cp ~/.dotfiles/.* ~

# -----------------------------------------------------------------------------

# 2. Vim Configuration

# -----------------------------------------------------------------------------

echo "Installing vim-plug for Vim..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing Vim plugins..."
vim +PlugInstall +qall

# -----------------------------------------------------------------------------

# 3. Nano Configuration

# -----------------------------------------------------------------------------

echo "Configuring nano..."
git clone https://github.com/scopatz/nanorc.git ~/.nano || true
#echo "include ~/.nano/*.nanorc" >> ~/.nanorc

# -----------------------------------------------------------------------------

# 4. Tmux & TPM Plugins

# -----------------------------------------------------------------------------

echo "Cloning TPM (Tmux Plugin Manager)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true

echo "Copying tmux config..."
cp ~/.dotfiles/.tmux.conf ~/.tmux.conf

echo "Installing tmux plugins..."
tmux source-file ~/.tmux.conf

# Note: Press Prefix (Ctrl-A) then I in a tmux session to install plugins

# -----------------------------------------------------------------------------

# 5. Zsh & Oh My Zsh

# -----------------------------------------------------------------------------

echo "Installing Zsh..."
sudo apt-get install zsh -y

echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Adding Zsh plugins..."
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"  || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true

echo "Configuring ~/.zshrc..."
sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

echo "Changing default shell to Zsh..."
chsh -s "$(which zsh)" || true

# -----------------------------------------------------------------------------

# 5. Node.js via NVM

# -----------------------------------------------------------------------------

echo "Installing NVM..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"

# shellcheck source=/dev/null

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

echo "Installing latest LTS version of Node.js..."
nvm install --lts

echo "Installing global npm tools..."
npm install -g yarn || true

# -----------------------------------------------------------------------------

# 6. Go (Golang)

# -----------------------------------------------------------------------------

echo "Installing Go (latest)..."
GO_LATEST=$(curl -s "https://go.dev/VERSION?m=text" | head -n 1)
GO_TARBALL="${GO_LATEST}.linux-amd64.tar.gz"
curl -LO "https://go.dev/dl/${GO_TARBALL}"

sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "${GO_TARBALL}"

echo "Configuring Go environment in ~/.zshrc..."
cat << 'EOF' >> ~/.zshrc

# Go environment

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
EOF

# shellcheck source=/dev/null

source ~/.zshrc

# -----------------------------------------------------------------------------

# 7. Docker

# -----------------------------------------------------------------------------

echo "Installing Docker..."
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo install -m0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo "Adding current user to docker group..."
sudo groupadd docker || true
sudo usermod -aG docker "$USER" || true
newgrp docker <<EONG
echo "Verifying Docker installation..."
docker run --rm hello-world
EONG

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Final Steps

# -----------------------------------------------------------------------------

echo "Reloading shell..."
exec "$SHELL" -l
