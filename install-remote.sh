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
    exit 1
fi

# Check if python3 is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: python3 is not installed${NC}"
    exit 1
fi

# Check if pip is installed
if ! command -v pip &> /dev/null; then
    echo -e "${RED}Error: pip is not installed${NC}"
    exit 1
fi

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
    pip install poetry
fi

# Install dependencies
echo -e "${GREEN}Installing dependencies...${NC}"
poetry install

# Run the local installer
echo -e "${GREEN}Running installer...${NC}"
./install.sh

# Clean up
cd ..
rm -rf git-commit-ai

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}Don't forget to set your OpenAI API key:${NC}"
echo -e "export OPENAI_API_KEY='your-api-key-here'"
echo -e "\nAdd it to your shell config (~/.bashrc, ~/.zshrc) for permanent use:"
echo -e "echo 'export OPENAI_API_KEY=\"your-api-key-here\"' >> ~/.bashrc"
echo -e "source ~/.bashrc"
