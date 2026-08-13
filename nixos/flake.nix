{
  description = "tsuki's config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swindle = {
      url = "github:kantiankant/swindle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sb = {
      url = "github:kantiankant/sb";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    termipedia = {
      url = "github:kantiankant/termipedia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    m701 = {
       url = "github:kantiankant/m701";
       inputs.nixpkgs.follows = "nixpkgs";
     };

    make2flake = {
      url = "github:kantiankant/make2flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    twobwc = {
      url = "hg+https://hg.hgdump.net/tsukasa/2bwc?ref=default"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.shitbox = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./hardware-configuration.nix
        ./configuration.nix
      ];
    };
  };
}
