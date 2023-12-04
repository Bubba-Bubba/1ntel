{
  description = "FLAKE - Marcus's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    
plugin-kanagawa.url = "github:rebelot/kanagawa.nvim";
    plugin-kanagawa.flake = false;

nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
helix.url = "github:helix-editor/helix/23.05"; 
  };

# minus nixvim
outputs = { self, nixpkgs, home-manager, nix-index-database, ... }@inputs : 
let
    system = "x86_64-linux";
    homeManagerModules = [ 
    nix-index-database.hmModules.nix-index
     ];
  in
{
    nixosConfigurations = {
      My_Nix = nixpkgs.lib.nixosSystem {
             inherit system;                  
            specialArgs = inputs;

                modules = [

                    ./configuration.nix
                            # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed 
          #automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
                #  home-manager.nixosModules.home-manager
          {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.marcus.imports = [
              ./home.nix  
                    ]
                   ++ homeManagerModules;
          };
          }

        ];
       };
        
      };
    };

}
