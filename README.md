# Mycorrhiza 💚 Nix

Package and module descriptions for [Mycorrhiza](https://github.com/bouncepaw/mycorrhiza)
wiki engine, lying here till joining Nixpkgs and home-manager.

## Installation

#### Package

While not in Nixpkgs, Mycorrhiza package is installed by adding it in
`packageOverrides` option of `nixpkgs` configuration, either local
(`~/.config/nixpkgs/config.nix`) or global (`/etc/nixos/configuration.nix`), 
like this:

```nix
nixpkgs.config.packageOverrides = super: let self = super.pkgs; in {
  mycorrhiza = import '<PATH-TO-REPO>' { pkgs = self; };
};
```

After that, install `mycorrhiza` package by method of your choice,
but better use modules below.

#### Home Manager module

The module is provided for self-hosting purposes (like, personal wiki) and
installed in Home Manager by importing the module and activating it with
options at `~/.config/nixpkgs/home.nix`:

```nix
imports = [
  <PATH-TO-REPO>/mycorrhiza-home.nix
];

services.mycorrhiza = {
  enable = true;
  wikiPath = "${config.home.homeDirectory}/wiki";
  # default path is ~/.mycorrhiza
};
```

## Roadmap

- [x] pack Mycorrhiza for Nix
- [x] write & test PoC Home-Manager module
- [ ] implement `listen-addr` option support
- [ ] write & test NixOS module
  - [ ] PoC with dedicated user
  - [ ] add multiinstancing
- [ ] push Mycorrhiza package & module to `nixpkgs`
- [ ] push Mycorrhiza module to `home-manager`
- [ ] maintain while true
