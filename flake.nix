{
  description = "Cursor IDE - AI-powered code editor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      cursor = pkgs.callPackage ./cursor.nix {
        buildVscode = pkgs.callPackage "${pkgs.path}/pkgs/applications/editors/vscode/generic.nix" {};
      };
      default = self.packages.${system}.cursor;
    });
  };
}
