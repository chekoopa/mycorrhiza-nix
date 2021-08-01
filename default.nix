{ pkgs ? ( import <nixpkgs> {} )
}:

let

 mycorrhiza = pkgs.callPackage ./package.nix {
   buildGoModule = pkgs.buildGo116Module;
 };

in if pkgs.lib.inNixShell then mycorrhiza.env else mycorrhiza

