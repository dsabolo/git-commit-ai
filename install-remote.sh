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

# Run the local installer
echo -e "${GREEN}Running installer...${NC}"
./install.sh

# Clean up
cd ..
rm -rf git-commit-ai

echo -e "${GREEN}Almost done!${NC}"
echo -e "${YELLOW}To complete the installation, run:${NC}"
echo -e "./finalize-install.sh"
