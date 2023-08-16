{
  description = "FLAKE - Marcus's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

helix.url = "github:helix-editor/helix/23.05"; 
  };

outputs = { self, nixpkgs, home-manager, ... }@inputs : {
    nixosConfigurations = {
      My_Nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
                  specialArgs = inputs;

         modules = [
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.marcus = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];

      };
    };
  };
}


