"""
Commit message generation and templates for git-commit-ai
"""

COMMIT_PROMPT = """Generate a commit message for the following changes.
Current branch: {branch}

Changed files:
{files}

Git diff:
{diff}

Return only:
1. A high-level title (without the commit type or branch)
2. A list of bullet points
3. No signatures or additional sections"""

COMMIT_TEMPLATE = """feat({branch}): {message}"""

SYSTEM_PROMPT = """You are a helpful assistant that generates clear and concise Git commit messages.
Follow these rules:
1. Use conventional commit format (feat, fix, docs, etc.)
2. Keep the title short, descriptive, and high-level (e.g., "Add initial project files" instead of listing all files)
3. List all changes in bullet points ONCE
4. Include both staged and unstaged changes
5. Be specific about what was modified
6. Don't include signatures or additional sections
7. Group related changes together
8. Return ONLY the title and bullet points, nothing else"""
