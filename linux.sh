#!/bin/sh

# Check if oh-my-zsh is installed
if [ ! -d ~/.oh-my-zsh ]; then
    echo "oh-my-zsh not installed, downloading and installing now..."

    # Clone ohmyzsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

else
    echo "oh-my-zsh was found, skipping installation!"
fi

echo "Installing nerd fonts..."

# Install powerline nerd fonts
git clone --depth=1 https://github.com/powerline/fonts
sh -c fonts/install.sh
rm -rf fonts

# Install Meslo Regular fonts
# TODO: This might not actually work, need to check it out
curl -o "/usr/share/fonts/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf

# Install zsh-auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install percol if required
if ! which percol >/dev/null; then
    echo "Percol not found, installing..."
    (pip install percol && percol_installed=1) || echo "Failed to install percol, check that python and pip are installed!"
else
    percol_installed=1
fi

plugins_list="git docker docker-compose jsontools copyfile web-search dirhistory zsh-autosuggestions"

# If percol is installed, add it to the plugins list
if [ $percol_installed -eq 1 ]; then
    plugins_list="$plugins_list percol"
fi

echo "Updating the plugins list for oh-my-zsh..."
sed -i -r "s/plugins\=.+/plugins=($plugins_list)/" ~/.zshrc

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Replacing theme to powerlevel10k..."
sed -i -r 's/ZSH_THEME\=.+/ZSH_THEME=powerlevel10k\/powerlevel10k/' ~/.zshrc

# Add tmux params
if which tmux >/dev/null; then
    echo "Tmux was found, installing configurations..."

    # Tmux configuration files
    tmux_conf=~/.tmux.conf

    # If tmux file not exists
    if ! test -f $tmux_conf; then
        echo "Creating .tmux.conf as it does not exist..."

        # Create the tmux config file
        touch $tmux_conf
    fi

    # Now add the configurations if not exists
    grep -qF "screen-256color" $tmux_conf || echo 'set -g default-terminal "screen-256color"' >>$tmux_conf
    grep -qF "mouse on" $tmux_conf || echo 'setw -g mouse on' >>$tmux_conf
fi

echo "Setup was finished! Please run 'source ~/.zshrc' or reload terminal to view the changes"
