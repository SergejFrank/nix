{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pentest_filepath = ./pentest;
  in {
    formatter.${system} = pkgs.alejandra;

    homeConfigurations.sfrank = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
      ];
    };

    homeConfigurations.pentest = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      
      modules = map (filename: pentest_filepath+ ("/"+filename)) (builtins.attrNames (builtins.readDir pentest_filepath));
    };
  };
}
