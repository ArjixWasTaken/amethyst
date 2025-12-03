# 🔮 Amethyst

A version manager, and project manager for [Amber](https://amber-lang.com), written in 100% Amber.

[![asciicast](https://asciinema.org/a/nmUSrF9jkXMcAqqmGKFA7wmhs.svg)](https://asciinema.org/a/nmUSrF9jkXMcAqqmGKFA7wmhs)

## 🚧 Under Construction 🚧
This project is under construction, and is not ready for regular use. <br />
Please only open issues if you are actually willing to make a PR yourself.

## Usage

Amethyst is a command-line tool for managing Amber projects and Amber versions.

```
Usage: amethyst <command> [options]
```

You can also execute an Amber script directly within an Amethyst project:
```sh
amethyst your-script.ab
```

## Commands

### Project Management

#### `init`
Bootstraps a new Amber project. It will prompt you for a project directory and create the necessary files and directory structure.

**Usage:**
```sh
amethyst init
```

**Example:**
```
$ amethyst init
Project directory: my-amber-project
Successfully created project 'my-amber-project'
```

This creates a new directory `my-amber-project` with the following structure:
```
my-amber-project/
├── amethyst.ini
├── my-amber-project.ab  (executable script)
├── .gitignore
└── lib/
```

#### `info`
Displays information about the current Amber project, such as the project root.

**Usage:**
```sh
amethyst info
```

#### `build`
Builds the current project. This command reads the `amethyst.ini` file for the project's entry point and compiles it into an executable shell script in the `target/` directory.

**Usage:**
```sh
amethyst build
```

### Environment

#### `env`
Generates the necessary shell commands to add Amethyst to your PATH. This is meant to be used with `eval`.

**Usage:**
```sh
source <(amethyst env)
```

### Amber Version Management (`amber`)

Amethyst can manage multiple versions of the Amber compiler.

#### `amber list`
Lists installed and available Amber versions.

**Usage:**
```sh
amethyst amber list [options]
```

**Options:**
- `--all`, `-a`: List all available remote versions for installation.

#### `amber install`
Installs a specific version of Amber.

**Usage:**
```sh
amethyst amber install <version> [options]
```

**Arguments:**
- `<version>`: The version to install. You can use `latest` to install the most recent version.

**Options:**
- `--force`, `-f`: Force re-installation if the version is already installed.

**Example:**
```sh
amethyst amber install latest
```

#### `amber uninstall`
Uninstalls a specific version of Amber.

**Usage:**
```sh
amethyst amber uninstall <version>
```

**Arguments:**
- `<version>`: The version to uninstall.

#### `amber use`
Sets the default Amber version to use globally.

**Usage:**
```sh
amethyst amber use <version>
```

**Arguments:**
- `<version>`: The installed version to use as the default.