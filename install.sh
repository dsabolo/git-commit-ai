#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up git-commit-ai...${NC}"

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# Determine OS-specific paths
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    INSTALL_DIR="/usr/local"
    PYTHON_SITE_PACKAGES="$INSTALL_DIR/lib/python$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')/site-packages"
else
    # Linux
    INSTALL_DIR="/usr"
    PYTHON_SITE_PACKAGES="/usr/lib/python3/dist-packages"
fi

# Install dependencies system-wide
echo -e "${GREEN}Installing dependencies...${NC}"
sudo $PIP_CMD install --upgrade pip
sudo $PIP_CMD install --target="$PYTHON_SITE_PACKAGES" openai gitpython pyyaml

# Create installation directories
sudo mkdir -p "$INSTALL_DIR/lib/git-commit-ai"
sudo mkdir -p "$INSTALL_DIR/bin"

# Copy files to installation directory
echo -e "${GREEN}Installing files...${NC}"
sudo cp -r "$SCRIPT_DIR"/* "$INSTALL_DIR/lib/git-commit-ai/"

# Create Git command wrapper
echo -e "${GREEN}Creating Git command...${NC}"
cat > git-commit-ai-cmd << EOL
#!/bin/bash
INSTALL_DIR="$INSTALL_DIR"

# Execute the script with system Python
exec python3 "\$INSTALL_DIR/lib/git-commit-ai/git-commit-ai" "\$@"
EOL

sudo mv git-commit-ai-cmd "$INSTALL_DIR/bin/git-commit-ai"
sudo chmod +x "$INSTALL_DIR/bin/git-commit-ai"

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}You can now use 'git commit-ai' to create commits with AI-generated messages${NC}"

echo -e "\n${YELLOW}Don't forget to set your OpenAI API key:${NC}"
echo -e "export OPENAI_API_KEY='your-api-key-here'"
