# Cursor Nightly Flake

A nightly updating flake for the Cursor IDE.

## Usage

Add to your flake.nix

```nix
cursor-flake = {
    url = "github://tylergets/cursor-flake";
    inputs.nixpkgs.follows = "nixpkgs";
};
```

The IDE will be available at `inputs.cursor-flake.packages.x86_linux.default`
