{ pkgs ? ( import <nixpkgs> {} )
}:

let

 mycorrhiza = pkgs.callPackage ./package.nix {
   buildGoModule = pkgs.buildGo116Module;
 };

in mycorrhiza

