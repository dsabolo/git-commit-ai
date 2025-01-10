#!/bin/bash

echo "Uninstalling git-commit-ai..."

# Remove the symbolic link
if [ -L "/usr/local/bin/git-commit-ai" ]; then
    sudo rm /usr/local/bin/git-commit-ai
    echo "✅ Removed git-commit-ai command"
else
    echo "⚠️  git-commit-ai command not found in /usr/local/bin"
fi

# Optionally remove Poetry environment
if [ -d ".venv" ]; then
    poetry env remove python
    echo "✅ Removed Poetry environment"
fi

echo "Note: Your OpenAI API key in your shell configuration remains unchanged."
