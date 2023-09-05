{
  description = "FLAKE - Marcus's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

nixvim = {
    url = "github:nix-community/nixvim";
  #  # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # url = "github:nix-community/nixvim/nixos-23.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };

nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  

helix.url = "github:helix-editor/helix/23.05"; 
  };

outputs = { self, nixpkgs, home-manager, nixvim, nix-index-database, ... }@inputs : 
let
    system = "x86_64-linux";
    homeManagerModules = [ 
    nixvim.homeManagerModules.nixvim
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
