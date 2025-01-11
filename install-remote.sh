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

# Determine OS-specific paths
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    INSTALL_DIR="/usr/local"
else
    # Linux
    INSTALL_DIR="/usr"
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo -e "${GREEN}Downloading latest version...${NC}"

# Clone the repository
git clone --depth 1 https://github.com/dsabolo/git-commit-ai.git
cd git-commit-ai

# Install dependencies globally
echo -e "${GREEN}Installing dependencies...${NC}"
$PIP_CMD install openai gitpython pyyaml

# Create installation directories
sudo mkdir -p "$INSTALL_DIR/lib/git-commit-ai"
sudo mkdir -p "$INSTALL_DIR/bin"

# Copy files to installation directory
echo -e "${GREEN}Installing files...${NC}"
sudo cp -r * "$INSTALL_DIR/lib/git-commit-ai/"

# Create Git command wrapper
echo -e "${GREEN}Creating Git command...${NC}"
cat > git-commit-ai-cmd << 'EOL'
#!/bin/bash
INSTALL_DIR="$(dirname $(dirname $(readlink -f $0)))"

# Ensure Python can find the installed packages
export PYTHONPATH="$INSTALL_DIR/lib/git-commit-ai:$PYTHONPATH"

# Execute the script
exec python3 "$INSTALL_DIR/lib/git-commit-ai/git-commit-ai" "$@"
EOL

sudo mv git-commit-ai-cmd "$INSTALL_DIR/bin/git-commit-ai"
sudo chmod +x "$INSTALL_DIR/bin/git-commit-ai"

# Clean up
cd ..
rm -rf git-commit-ai

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}You can now use 'git commit-ai' to create commits with AI-generated messages${NC}"

echo -e "\n${YELLOW}Don't forget to set your OpenAI API key:${NC}"
echo -e "export OPENAI_API_KEY='your-api-key-here'"
