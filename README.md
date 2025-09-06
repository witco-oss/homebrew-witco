# Homebrew Witco

A Homebrew tap for Witco CLI tools.

## Installation

### Geekbot CLI

Install the Geekbot CLI tool:

```bash
brew tap witco/witco https://tavern.witco.net/witco/homebrew-witco.git
brew install geekbot-cli
```

## Tools

### geekbot-cli

Command-line interface for Geekbot automation and management.

#### Authentication

The CLI uses AWS SSO for authentication. On first use, you'll be prompted to configure your AWS credentials:

```bash
aws sso login --profile geekbot-cli
```

#### Environment Variables

You can customize the AWS configuration by setting these environment variables before installation:

- `AWS_ACCOUNT_ID` - AWS account ID (default: 197848513456)
- `AWS_ROLE` - AWS role name (default: all-bootstrap)

Example:

```bash
AWS_ACCOUNT_ID=123456789012 AWS_ROLE=my-role brew install geekbot-cli
```

## Documentation

For more information:
- Use `brew help` or `man brew`
- Visit [Homebrew's documentation](https://docs.brew.sh)
- For Geekbot CLI usage: `geekbot-cli --help`