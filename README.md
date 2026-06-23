<div align="center">

# ❄️ MyNixOS

A beautiful, modular, and declarative NixOS configuration powered by **Flakes** and **Flake Parts**.

![NixOS](https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&logo=NixOS&logoColor=white)

</div>

---

## 🌟 Overview

Welcome to my personal NixOS configuration! This repository defines a fully reproducible system state, configured declaratively using modern Nix ecosystem tooling.

By utilizing [`flake-parts`](https://flake.parts) and [`import-tree`](https://github.com/vic/import-tree), the codebase stays highly organized and scalable across multiple machines and custom system features.

## ✨ Features

- **Modern Nix Tooling**: Driven by Flakes, `flake-parts`, and `nix-wrapper-modules` for a sleek module system.
- **Niri Compositor**: Built-in declarative support for the [Niri](https://github.com/YaLTeR/niri) scrollable-tiling Wayland compositor.
- **Modular Design**: Features and host configurations are strictly decoupled, making it effortless to mix and match capabilities.
- **Reproducible**: Pinned inputs in `flake.lock` guarantee the same setup everywhere.

---

## 📂 Architecture

The repository is structured to separate system configurations by logical responsibilities:

```text
📦 MyNixOS
 ┣ 📜 flake.nix              # The entry-point defining inputs and flake-parts structure
 ┣ 📜 flake.lock             # Pinned dependency versions
 ┗ 📂 modules
   ┣ 📂 features             # Reusable system building blocks
   ┃ ┣ 📜 niri.nix           # Wayland compositor configuration
   ┃ ┗ 📜 noctalia.nix       # Custom feature profiles
   ┗ 📂 hosts                # Machine-specific configurations
     ┗ 📂 my-machine         # Primary setup for 'my-machine'
```

---

## 🚀 Getting Started

### Prerequisites

Ensure that your system is running NixOS and that **Flakes** and the **`nix-command`** experimental features are enabled.

### Deployment

To build and switch to the `my-machine` host configuration, run the following command from the root of this repository:

```bash
sudo nixos-rebuild switch --flake .#my-machine
```

Alternatively, you can test the build without applying it:

```bash
nixos-rebuild build --flake .#my-machine
```

---

## 🛠️ Built With

- [**NixOS Unstable**](https://github.com/nixos/nixpkgs) - The core operating system branch.
- [**flake-parts**](https://flake.parts/) - For simplified and sane Flake structuring.
- [**import-tree**](https://github.com/vic/import-tree) - Effortless directory-based module importing.
- [**nix-wrapper-modules**](https://github.com/BirdeeHub/nix-wrapper-modules) - Advanced module abstraction options.

<div align="center">
  <i>Stay reproducible.</i>
</div>
