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

## Installation

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

The commit message format and AI prompts can be customized by editing `prompt_config.py`. The default format follows the conventional commit style:

```
feat(branch): Descriptive title

- Detailed change 1
- Detailed change 2
```

## Uninstallation

To uninstall:
```bash
./uninstall.sh
```

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
