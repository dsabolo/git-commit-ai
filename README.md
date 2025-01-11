# Git AI Commit Message Generator

A Git extension that uses OpenAI's GPT to automatically generate meaningful commit messages based on your changes.

## Features

- Automatically generates commit messages using AI
- Shows both staged and unstaged changes
- Includes branch name and structured changes list
- Uses your default Git editor
- Follows Git commit message best practices
- Generates messages in conventional commit format

## Requirements

1. Python 3.8 or later
2. Git
3. OpenAI API key

Supported platforms:
- Linux (Ubuntu, Debian, etc.)
- macOS

## Installation

### Quick Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/dsabolo/git-commit-ai/main/install-remote.sh | bash
```

This will:
- Check and install required dependencies
- Set up the Git command
- Create example configuration
- Guide you through API key setup

If you're missing any dependencies, the installer will tell you how to install them:
- On macOS: Using `brew` or Python's built-in tools
- On Linux: Using your package manager

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

4. Set your OpenAI API key:
```bash
export OPENAI_API_KEY='your-api-key-here'
```

To make the API key permanent, add it to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):
```bash
echo 'export OPENAI_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

## Usage

1. Make some changes to your code

2. Run:
```bash
git commit-ai
```

The tool will:
- Stage any unstaged changes
- Generate a commit message using AI
- Open your default Git editor to review/edit the message
- Create the commit when you save and exit
- Cancel the commit if you exit without saving

## Configuration

The commit message format and AI behavior can be customized per project by creating a `.git-commit-ai.yml` file in your repository root. The tool will automatically detect and use this configuration.

### Custom Configuration

1. Copy the example configuration:
```bash
cp .git-commit-ai.yml.example .git-commit-ai.yml
```

2. Edit the file to customize:
- `system_prompt`: Instructions for the AI's behavior
- `commit_prompt`: Template for generating the message
- `commit_template`: Final commit message format

Example configuration:
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

### Available Variables

The following variables are available in the prompts:
- `{branch}`: Current Git branch name
- `{files}`: List of changed files
- `{diff}`: Git diff of changes

### Default Behavior

If no `.git-commit-ai.yml` is found, the tool will use its built-in defaults, which follow conventional commit format and best practices.

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

## Uninstallation

To uninstall:
```bash
./uninstall.sh
```

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
