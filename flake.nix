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
  

nix-alien.url = "github:thiagokokada/nix-alien";
helix.url = "github:helix-editor/helix/23.05"; 
  };

outputs = { self, nixpkgs, home-manager, nixvim, nix-index-database, nix-alien, ... }@inputs : 
let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    homeManagerModules = [ 
    nixvim.homeManagerModules.nixvim
    nix-index-database.hmModules.nix-index
     ];
  in
{
      homeConfigurations.nix-alien-home = home-manager.lib.homeManagerConfiguration rec {
          inherit pkgs;
            extraSpecialArgs = { inherit self system; };
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

               ({ self, system, ... }: {                                              
                 home.packages = with self.inputs.nix-alien.packages.${system}; [     
                   nix-alien                                                          
                 ];                                                                   
              })                                                                     
             ];
       };
        
      };
    };
};
}
