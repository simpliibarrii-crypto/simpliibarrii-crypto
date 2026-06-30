# Contributing to Raven AI

Thank you for your interest in contributing to Raven AI — your intelligence layer
for sovereign, local-first AI.

## Code of Conduct

This project adheres to the [Contributor Covenant](CODE_OF_CONDUCT.md).
By participating, you agree to uphold its standards.

## How to Contribute

### Reporting Bugs

1. Check the issue tracker for existing reports
2. Use the bug report template
3. Include steps to reproduce, expected behavior, and environment details

### Feature Requests

1. Search existing issues and discussions for similar ideas
2. Use the feature request template
3. Explain the use case and proposed solution

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/description`
3. Make your changes following our conventions
4. Ensure CI passes (lint, format, tests)
5. Open a pull request against `main`

## Development Setup

```bash
# Clone your fork
git clone https://github.com/your-username/raven-ai.git
cd raven-ai

# Install dependencies
pip install -e .[dev]
pre-commit install

# Run tests
make test
make lint
```

## Style Guidelines

* Follow PEP 8 for Python code
* Use type hints for all function signatures
* Write docstrings for public APIs
* Keep functions focused and small
* Write tests for new functionality

## Commit Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):

* `feat:` — new feature
* `fix:` — bug fix
* `docs:` — documentation
* `style:` — formatting, no logic change
* `refactor:` — code restructuring
* `test:` — adding or updating tests
* `chore:` — maintenance tasks

## Governance

See [GOVERNANCE.md](GOVERNANCE.md) for project governance details.

## Questions?

Open a discussion or email bclerjuste@gmail.com.
