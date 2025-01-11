#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up git-commit-ai...${NC}"

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Determine shell config file
SHELL_CONFIG="$HOME/.bashrc"
if [[ "$SHELL" == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

# Create Git command directory if it doesn't exist
GIT_COMMANDS_DIR="$HOME/.local/bin"
mkdir -p "$GIT_COMMANDS_DIR"

# Create symlink for Git command
echo -e "${GREEN}Creating Git command...${NC}"
if [ -f "$GIT_COMMANDS_DIR/git-commit-ai" ]; then
    echo -e "${YELLOW}Removing existing symlink...${NC}"
    rm "$GIT_COMMANDS_DIR/git-commit-ai"
fi

ln -s "$SCRIPT_DIR/git-commit-ai" "$GIT_COMMANDS_DIR/git-commit-ai"
chmod +x "$GIT_COMMANDS_DIR/git-commit-ai"

# Add Git commands directory to PATH if needed
if [[ ":$PATH:" != *":$GIT_COMMANDS_DIR:"* ]]; then
    echo -e "${YELLOW}Adding Git commands directory to PATH...${NC}"
    echo "export PATH=\"$GIT_COMMANDS_DIR:\$PATH\"" >> "$SHELL_CONFIG"
    export PATH="$GIT_COMMANDS_DIR:$PATH"
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}You can now use 'git commit-ai' to create commits with AI-generated messages${NC}"

echo -e "\n${YELLOW}Don't forget to set your OpenAI API key:${NC}"
echo -e "export OPENAI_API_KEY='your-api-key-here'"
echo -e "\nAdd it to your shell config for permanent use:"
echo -e "echo 'export OPENAI_API_KEY=\"your-api-key-here\"' >> $SHELL_CONFIG"
