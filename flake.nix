{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    attic.url = "github:zhaofengli/attic";
    nix-serve-ng.url = "github:aristanetworks/nix-serve-ng";
  };
  outputs = { self, nixpkgs, nixos-generators, attic, nix-serve-ng, ... }: 
let
  mods = [
    attic.nixosModules.atticd
    nix-serve-ng.nixosModules.default
    ./configuration.nix
  ];
  createVmOfType = type: nixos-generators.nixosGenerate {
    system = "x86_64-linux";
    modules = mods;
    format = type;
  };
in
  rec {
      packages.x86_64-linux = {
        openstack = createVmOfType "openstack";
        vm = createVmOfType "vm";
      };
      packages.x86_64-linux.default = packages.x86_64-linux.openstack;
    };
  }
