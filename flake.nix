{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs = {
    self,
    nixpkgs,
    nix-ai-tools,
  }: {
    packages = {
      x86_64-linux = let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in {
        default = pkgs.callPackage ./cursor.nix {
          cursor-agent = nix-ai-tools.packages.${pkgs.system}.cursor-agent;
          vscode-generic = import "${pkgs.path}/pkgs/applications/editors/vscode/generic.nix";
        };
      };
    };
  };
}
