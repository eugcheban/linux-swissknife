#!/bin/bash

packages=(
    "git"
    "vim"
    "byobu"
    "chromium"
    "qbittorrent"
    "vlc"
    "tor"

    # development
    "python3-pytest"
)

install_packages() {
    for pkg in "${packages[@]}"; do
        # Skip comments and blank lines
        [[ "$pkg" =~ ^#.*$ || -z "$pkg" ]] && continue
        # Skip custom entries (like configs or downloaded apps)
        if [[ "$pkg" == "vscode" || "$pkg" == "discord" || "$pkg" == "anki" ]]; then
            echo "Skipping $pkg (manual install required)"
            continue
        fi
        echo "Installing $pkg..."
        sudo apt-get install -y "$pkg"
    done
}

# Call the function
install_packages

# ...existing code...