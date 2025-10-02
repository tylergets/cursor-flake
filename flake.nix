{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    packages = {
      x86_64-linux = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in {
        default = pkgs.callPackage ./cursor.nix {
          vscode-generic = import "${pkgs.path}/pkgs/applications/editors/vscode/generic.nix";
        };
      };
    };
  };
}
