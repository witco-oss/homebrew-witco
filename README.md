# Homebrew Witco

A Homebrew tap for Witco CLI tools.

> **Note:** This private repository is mirrored for public access at https://github.com/witco-oss/homebrew-witco

## Installation

### witco-cli

Install the Witco CLI tool:

```bash
brew tap witco/witco https://github.com/witco-oss/homebrew-witco.git
brew install witco-cli
```

## Tools

### Witco CLI

Command-line interface for Witco operations. Installs the `witctl` binary.

#### Authentication

The formula automatically handles AWS SSO authentication during installation and upgrades. You'll be prompted to authenticate via your browser if needed.

#### Environment Variables

You can customize the AWS configuration by setting these environment variables before installation:

- `AWS_ACCOUNT_ID` - AWS account ID (default: 197848513456)
- `AWS_ROLE` - AWS role name (default: all-bootstrap)

Example:

```bash
AWS_ACCOUNT_ID=123456789012 AWS_ROLE=my-role brew install witco-cli
```

## Documentation

For more information:

- Use `brew help` or `man brew`
- Visit [Homebrew's documentation](https://docs.brew.sh)
- For witctl usage: `witctl --help`
