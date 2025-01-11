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

# Determine OS-specific paths
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    INSTALL_DIR="/usr/local"
else
    # Linux
    INSTALL_DIR="/usr"
fi

# Create installation directories
sudo mkdir -p "$INSTALL_DIR/lib/git-commit-ai"
sudo mkdir -p "$INSTALL_DIR/bin"

# Copy files to installation directory
echo -e "${GREEN}Installing files...${NC}"
sudo cp -r "$SCRIPT_DIR"/* "$INSTALL_DIR/lib/git-commit-ai/"

# Create Git command
echo -e "${GREEN}Creating Git command...${NC}"
cat > git-commit-ai-cmd << 'EOL'
#!/bin/bash
INSTALL_DIR="$(dirname $(dirname $(readlink -f $0)))"
exec "$INSTALL_DIR/lib/git-commit-ai/git-commit-ai" "$@"
EOL

sudo mv git-commit-ai-cmd "$INSTALL_DIR/bin/git-commit-ai"
sudo chmod +x "$INSTALL_DIR/bin/git-commit-ai"

# Add Git commands directory to PATH if needed
if [[ ":$PATH:" != *":$INSTALL_DIR/bin:"* ]]; then
    echo -e "${YELLOW}Adding Git commands directory to PATH...${NC}"
    echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\"" >> "$SHELL_CONFIG"
    export PATH="$INSTALL_DIR/bin:$PATH"
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${YELLOW}You can now use 'git commit-ai' to create commits with AI-generated messages${NC}"

echo -e "\n${YELLOW}Don't forget to set your OpenAI API key:${NC}"
echo -e "export OPENAI_API_KEY='your-api-key-here'"
echo -e "\nAdd it to your shell config for permanent use:"
echo -e "echo 'export OPENAI_API_KEY=\"your-api-key-here\"' >> $SHELL_CONFIG"
