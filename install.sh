#!/bin/bash

echo "Installing git-commit-ai..."

# Check if Python 3.8+ is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is required but not installed. Please install Python 3.8 or later."
    exit 1
fi

# Check Python version
if python3 -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)"; then
    echo "✅ Python version check passed"
else
    echo "Python 3.8 or later is required. Found: $(python3 --version)"
    exit 1
fi

# Check if Poetry is installed
if ! command -v poetry &> /dev/null; then
    echo "Poetry not found. Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
    
    # Add Poetry to PATH for the current session
    export PATH="$HOME/.local/bin:$PATH"
fi

# Install dependencies using Poetry
echo "Installing dependencies..."
poetry install

# Make the script executable
chmod +x git-commit-ai

# Create symbolic link
echo "Creating symbolic link..."
sudo ln -sf "$(pwd)/git-commit-ai" /usr/local/bin/git-commit-ai

echo "✅ Installation complete!"
echo "You can now use 'git commit-ai' to create commits with AI-generated messages"
echo
echo "Before using, make sure to set your OpenAI API key:"
echo "export OPENAI_API_KEY='your-api-key-here'"
