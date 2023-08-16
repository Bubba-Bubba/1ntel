{
  description = "FLAKE - for master NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 helix.url = "github:helix-editor/helix/23.05";
 };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "My_Nix" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
specialArgs = inputs; 

       modules = [

          ./configuration.nix
        ];
      };
    };
  };
}
