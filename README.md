# git-commit-ai 🤖

AI-powered Git commit message generator using OpenAI's GPT. It analyzes your staged changes and generates meaningful, conventional commit messages.

## Features

- 🧠 Intelligent commit message generation
- 📝 Conventional commit format
- ⚙️ Project-specific customization
- 🔄 Automatic staging of tracked changes
- 🎨 Beautiful and descriptive commit messages

## Requirements

- Python 3.8 or later
- Git
- OpenAI API key

Supported platforms:
- Linux (Ubuntu, Debian, etc.)
- macOS

## Installation

### Quick Install (Recommended)

```bash
# Install git-commit-ai
curl -fsSL https://raw.githubusercontent.com/dsabolo/git-commit-ai/main/install-remote.sh | bash

# Open a new terminal or reload your shell configuration:
source ~/.bashrc  # or ~/.zshrc if using zsh
```

The installer will:
- Check and install required dependencies
- Set up the Git command
- Configure your PATH
- Create example configuration
- Guide you through API key setup

### Manual Installation

1. Clone this repository:
```bash
git clone https://github.com/dsabolo/git-commit-ai.git
cd git-commit-ai
```

2. Install dependencies:
```bash
pip install poetry
poetry install
```

3. Run the installer:
```bash
./install.sh
```

## Configuration

### OpenAI API Key

Set your OpenAI API key in your shell configuration:

```bash
# Add to ~/.bashrc or ~/.zshrc:
export OPENAI_API_KEY='your-api-key-here'

# Reload configuration:
source ~/.bashrc  # or ~/.zshrc if using zsh
```

### Custom Prompts

You can customize the commit message format by creating a `.git-commit-ai.yml` file in your repository root:

```yaml
# System prompt for the AI
system_prompt: |
  You are a helpful assistant that generates clear and concise Git commit messages.
  Follow these rules:
  1. Use conventional commit format (feat, fix, docs, etc.)
  2. Keep the title short and descriptive
  3. List all changes in bullet points
  4. Be specific about modifications

# Prompt for generating commit messages
commit_prompt: |
  Generate a commit message for the following changes.
  Current branch: {branch}

  Changed files:
  {files}

  Git diff:
  {diff}

  Return only:
  1. A high-level title
  2. A list of bullet points

# Template for the final commit message
commit_template: "feat({branch}): {message}"
```

## Usage

1. Make some changes to your code

2. Run:
```bash
git commit-ai
```

The tool will:
- Stage any modified tracked files (like `git commit -am`)
- Generate a commit message using AI
- Open your default Git editor to review/edit the message
- Create the commit when you save and exit
- Cancel the commit if you exit without saving

## Example Output

```
feat(auth): Add user authentication system

- Create User model with email and password fields
- Implement JWT token generation and validation
- Add login and register endpoints
- Set up password hashing with bcrypt
- Add user authentication middleware
```

## Uninstallation

```bash
# Run the uninstaller
./uninstall.sh
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
