# Zsh Configuration Project

This project contains a modular and well-structured Zsh configuration setup designed to enhance your shell experience. It includes aliases, functions, environment exports, options, personal customizations, integrations, and distro-specific settings.

## Project Structure

- `.zsh/aliases.zsh` — Commonly used command aliases.
- `.zsh/functions.zsh` — Helper functions and utilities.
- `.zsh/export.zsh` — Environment variable exports.
- `.zsh/options.zsh` — Zsh options and shell behavior settings.
- `.zsh/personal.zsh` — Personal aliases and customizations.
- `.zsh/integrations.zsh` — Plugin manager (Zinit) and integrations.
- `.zsh/distro/` — Distribution-specific configurations for Arch Linux, Ubuntu, macOS.
- `.zsh/themes/` — Theme files, including Powerlevel10k.

## Features

- Modular configuration for easy maintenance and customization.
- Automatic detection and loading of distribution-specific settings.
- Integration with Zinit plugin manager for efficient plugin handling.
- Support for popular plugins like syntax highlighting, autosuggestions, and fzf-tab.
- Powerlevel10k theme integration for a modern and informative prompt.
- Useful aliases and functions to speed up common tasks.
- Cache mechanism for command availability to optimize performance.

## Installation

1. Clone this repository to your home directory or preferred location.

2. Ensure you have Zsh installed and set as your default shell.

3. Source the `.zshrc` file in your home directory or link it to the one in this project:

   ```bash
   ln -s /path/to/project/.zshrc ~/.zshrc
   ```

4. Restart your terminal or run:

   ```bash
   source ~/.zshrc
   ```

5. The configuration will automatically detect your OS and load the appropriate settings.

## Dependencies

- Zsh shell
- Git
- Zinit plugin manager (automatically installed if missing)
- Various utilities depending on your distribution (see `install_zshrc_support` function)

## Troubleshooting

- If you encounter errors related to missing commands or plugins, run the `install_zshrc_support` function to install necessary packages.
- For SSH key issues, ensure your keys are valid and supported (prefer `ed25519` keys).
- If you see errors about unknown options or missing functions, verify your Zsh version and update plugins.

## Contributing

Feel free to fork this repository and submit pull requests for improvements or fixes.

## License

This project is open source and available under the MIT License.

---

*Created and maintained by Chris Engelhard*