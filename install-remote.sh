#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Installing git-commit-ai...${NC}"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    echo -e "Please install git first:"
    echo -e "  - Mac: brew install git"
    echo -e "  - Ubuntu/Debian: sudo apt install git"
    exit 1
fi

# Check for python3
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: python3 is not installed${NC}"
    echo -e "Please install Python 3 first:"
    echo -e "  - Mac: brew install python3"
    echo -e "  - Ubuntu/Debian: sudo apt install python3"
    exit 1
fi

# Check for pip/pip3
if command -v pip3 &> /dev/null; then
    PIP_CMD="pip3"
elif command -v pip &> /dev/null; then
    PIP_CMD="pip"
else
    echo -e "${RED}Error: pip is not installed${NC}"
    echo -e "Please install pip first:"
    echo -e "  - Mac: python3 -m ensurepip"
    echo -e "  - Ubuntu/Debian: sudo apt install python3-pip"
    exit 1
fi

# Determine shell config file
SHELL_CONFIG="$HOME/.bashrc"
if [[ "$SHELL" == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

# Create Git commands directory if it doesn't exist
GIT_COMMANDS_DIR="$HOME/.local/bin"
mkdir -p "$GIT_COMMANDS_DIR"

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo -e "${GREEN}Downloading latest version...${NC}"

# Clone the repository
git clone --depth 1 https://github.com/dsabolo/git-commit-ai.git
cd git-commit-ai

# Install poetry if not installed
if ! command -v poetry &> /dev/null; then
    echo -e "${YELLOW}Installing poetry...${NC}"
    $PIP_CMD install poetry
fi

# Install dependencies
echo -e "${GREEN}Installing dependencies...${NC}"
poetry install

# Create symlink for Git command
echo -e "${GREEN}Creating Git command...${NC}"
if [ -f "$GIT_COMMANDS_DIR/git-commit-ai" ]; then
    echo -e "${YELLOW}Removing existing symlink...${NC}"
    rm "$GIT_COMMANDS_DIR/git-commit-ai"
fi

ln -s "$(pwd)/git-commit-ai" "$GIT_COMMANDS_DIR/git-commit-ai"
chmod +x "$GIT_COMMANDS_DIR/git-commit-ai"

# Add Git commands directory to PATH if needed
if [[ ":$PATH:" != *":$GIT_COMMANDS_DIR:"* ]]; then
    echo -e "${YELLOW}Adding Git commands directory to PATH...${NC}"
    echo "export PATH=\"$GIT_COMMANDS_DIR:\$PATH\"" >> "$SHELL_CONFIG"
    export PATH="$GIT_COMMANDS_DIR:$PATH"
fi

echo -e "${GREEN}Installation complete!${NC}"

# Test installation
if command -v git-commit-ai &> /dev/null; then
    echo -e "${GREEN}✅ git-commit-ai installed successfully!${NC}"
else
    echo -e "${YELLOW}⚠️  Please open a new terminal or run:${NC}"
    echo -e "source $SHELL_CONFIG"
fi

echo -e "\n${YELLOW}Don't forget to set your OpenAI API key:${NC}"
echo -e "export OPENAI_API_KEY='your-api-key-here'"
echo -e "\nAdd it to your shell config for permanent use:"
echo -e "echo 'export OPENAI_API_KEY=\"your-api-key-here\"' >> $SHELL_CONFIG"
