{ pkgs ? ( import <nixpkgs> {} )
, mycorrhiza ? ( import ./default.nix {} )
}:

mycorrhiza.overrideAttrs (attrs: {
  src = null;
  nativeBuildInputs = [ pkgs.govers ] ++ attrs.nativeBuildInputs;
  shellHook = ''
    echo 'Entering ${attrs.pname}'
    set -v
    export GOPATH="$(pwd)/.go"
    export GOCACHE=""
    export GO116MODULE='on'
    set +v
  '';
})

