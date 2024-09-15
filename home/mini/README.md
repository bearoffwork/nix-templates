# The Home Minimal Template

- A minimal [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone) configuration flake.
- Completely documented.
- Zsh with prompt (powerlevel10k/starship) options.
- [direnv](https://direnv.net) with [nix-direnv](https://github.com/nix-community/nix-direnv) for [nix-shell](https://nixos.wiki/wiki/Development_environment_with_nix-shell) auto activation
- Opt-in git config with github-cli credential helper.

## Template files

#### `flake.nix`
Entrypoint of [nix flakes](https://nix.dev/concepts/flakes.html), declares inputs, and outputs, in this template, it outputs home-manager configuration.

#### `home.nix`
Main home-manager module, declares some basic info for home-manager.

#### `modules` directory
Here's where we place our [modules](https://nixos.wiki/wiki/NixOS_modules), it just simply nix expressions spilt in another file.
there two kinds of modules:

<details>
<summary>Simple file modules</summary>

Just a file contains nix expressions.
```nix
import ./path/to/module.nix
```
</details>

<details>
<summary>Directory modules</summary>

A more complex modules, may have multiple files for readability, must contains default.nix at root of module.
for example:

```
home.nix
modules
└──zsh                     # module zsh
   ├── default.nix
   ├── powerlevel10k.nix   # file module `p10k` inside module `zsh` 
   └── starship            # dir module `starship` inside module `zsh`
       ├── default.nix
       └── starship.toml
```

Include it from home.nix
```
# home.nix
{
    imports = [
        ./modules/zsh
    ]
}
```
</details>