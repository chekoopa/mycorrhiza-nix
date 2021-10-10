{ pkgs ? ( import <nixpkgs> {} )
, mycorrhiza ? ( import ./default.nix {} )
}:

let
  go-localize = pkgs.callPackage ./go-localize {
    buildGoModule = pkgs.buildGo116Module;
  };
in
mycorrhiza.overrideAttrs (attrs: {
  src = null;
  nativeBuildInputs = attrs.nativeBuildInputs ++ (
    with pkgs; [
      delve
      golint
      govers
      quicktemplate
      go-localize
    ]
  );
  shellHook = ''
    echo 'Entering ${attrs.pname}'
    set -v
    export GOPATH="$(pwd)/.go"
    export GOCACHE=""
    export GO116MODULE='on'
    set +v
  '';
})

