# Bear's nix-templates

## Templates

- [home-mini](./templates/home/mini):
    - A minimal [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone) configuration flake.
    - Completely Documented
    - Zsh with prompt (powerlevel10k/starship) options.
    - [direnv](https://direnv.net) with [nix-direnv](https://github.com/nix-community/nix-direnv) for [nix-shell](https://nixos.wiki/wiki/Development_environment_with_nix-shell) auto activation
    - Opt-in git config with github-cli credential helper.
    

- [TBD][home-complete](./templates/home/complete):
    - Complete home-manager configuration of my config, though it may not always be up-to-date. 

- [TBD]php83:
    - php 8.3 dev shell with only required extension, for laravel.


## Templates Usage: `home-*`

### Step 1. Update nix.conf

Add yourself to trusted-users.
```ini
trusted-users = <$USER>
```

Enable some features, this is required for this template.
```ini
extra-experimental-features = nix-command flakes
```

Opinionated: follow XDG Base Directory to keep home directory clean.
```ini
use-xdg-base-directories = true
```

After all your nix config will looks like this:
```ini
build-users-group = nixbld
trusted-users = <your user name>
extra-experimental-features = nix-command flakes
use-xdg-base-directories = true
```

### Step 2. Get the template

Generate home-manager flake at default location.
```shell
# For home-mini
nix flake new -t github:bearoffwork/nix-templates#home-mini ~/.config/home-manager

# [WIP] home-complete
```

### Step 3. Update some required info of config.

Update user hostname and
```shell
cd ~/.config/home-manager

# Update template username.
nix run nixpkgs#gnused -- -i "s/{{ username }}/$USER/" flake.nix home.nix

# Update system type declaration.
nix run nixpkgs#gnused -- -i "s/\"{{ system }}\"/$(nix eval --impure --expr 'builtins.currentSystem')/" flake.nix

```

### Step 4. Activate home-manager

If you generate the template at default location.
```shell
nix run home-manager switch
```

It's possible to override home-manager default config directory, for example:
```shell
nix flake new -t github:bearoffwork/nix-templates#home-mini ~/src/home
nix run home-manager --flake ~/src/home switch
```

After home manager activation, you can run following command once you update your config:
```
home-manager switch
```
Or this if you're using alternative home-manager config location.
```
home-manager --flake /path/to/your/config switch
```