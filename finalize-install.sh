#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Finalizing git-commit-ai installation...${NC}"

# Add /usr/local/bin to PATH
export PATH="/usr/local/bin:$PATH"

# Determine shell config file
SHELL_CONFIG="$HOME/.bashrc"
if [[ "$SHELL" == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

# Add to shell config if not already there
if ! grep -q "PATH.*\/usr\/local\/bin" "$SHELL_CONFIG"; then
    echo -e "${YELLOW}Adding /usr/local/bin to PATH in $SHELL_CONFIG${NC}"
    echo 'export PATH="/usr/local/bin:$PATH"' >> "$SHELL_CONFIG"
fi

# Test installation
if command -v git-commit-ai &> /dev/null; then
    echo -e "${GREEN}✅ git-commit-ai installed successfully!${NC}"
    echo -e "${YELLOW}Don't forget to set your OpenAI API key:${NC}"
    echo -e "export OPENAI_API_KEY='your-api-key-here'"
    echo -e "\nAdd it to your shell config for permanent use:"
    echo -e "echo 'export OPENAI_API_KEY=\"your-api-key-here\"' >> $SHELL_CONFIG"
else
    echo -e "${RED}❌ Installation may have failed. Please check the error messages above.${NC}"
fi
