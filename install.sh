#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up git-commit-ai...${NC}"

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Determine OS type and shell config
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    INSTALL_DIR="/usr/local/bin"
    if [[ "$SHELL" == */zsh ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi
else
    # Linux
    INSTALL_DIR="/usr/local/bin"
    if [[ "$SHELL" == */zsh ]]; then
        SHELL_CONFIG="$HOME/.zshrc"
    else
        SHELL_CONFIG="$HOME/.bashrc"
    fi
fi

# Create symlink
echo -e "${GREEN}Creating command symlink...${NC}"
if [ -f "$INSTALL_DIR/git-commit-ai" ]; then
    echo -e "${YELLOW}Removing existing symlink...${NC}"
    sudo rm "$INSTALL_DIR/git-commit-ai"
fi

sudo ln -s "$SCRIPT_DIR/git-commit-ai" "$INSTALL_DIR/git-commit-ai"
sudo chmod +x "$INSTALL_DIR/git-commit-ai"

# Update PATH if needed
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${YELLOW}Adding $INSTALL_DIR to PATH...${NC}"
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$SHELL_CONFIG"
fi

# Source the shell config
echo -e "${GREEN}Updating shell configuration...${NC}"
if [ -f "$SHELL_CONFIG" ]; then
    # Export PATH for current session
    export PATH="$PATH:$INSTALL_DIR"
    
    # Source the config file in the current shell
    source "$SHELL_CONFIG" 2>/dev/null || . "$SHELL_CONFIG"
    
    # Also source it in parent shell by writing to temp file
    TEMP_SOURCE=$(mktemp)
    echo "source \"$SHELL_CONFIG\"" > "$TEMP_SOURCE"
    echo "rm \"$TEMP_SOURCE\"" >> "$TEMP_SOURCE"
    echo -e "${YELLOW}Shell config updated. Changes will take effect in new terminal windows.${NC}"
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}You can now use 'git commit-ai' to create commits with AI-generated messages${NC}"

echo -e "\n${YELLOW}Don't forget to set your OpenAI API key:${NC}"
echo -e "export OPENAI_API_KEY='your-api-key-here'"
echo -e "\nAdd it to your shell config for permanent use:"
echo -e "echo 'export OPENAI_API_KEY=\"your-api-key-here\"' >> $SHELL_CONFIG"
