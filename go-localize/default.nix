{ stdenv, lib, fetchFromGitHub, buildGoModule
, makeWrapper, git
}:

let
  devBuild = false;
in
buildGoModule rec {
  pname = "go-localize";
  version = "0.4.0";

  src = if devBuild
    then ../../go-localize
    else fetchFromGitHub {
      owner = "chekoopa";
      repo = "${pname}";
      rev = "v${version}";
      sha256 = "18km6pas4fz0qn06nklqk91yzrnm11jcprfjb365qhid4qjbb1d1";
      fetchSubmodules = true;
    };

  vendorSha256 = "0n4kafd00xmh0s15nnr0lavfbsqj2sbpcs2bm1ply7lbyclnm0yf";

  subPackages = [ "." ];

  nativeBuildInputs = [ makeWrapper ];
  propagatedBuildInputs = [ git ];

  meta = with lib; {
    description = "i18n (Internationalization and localization) engine written in Go, used for translating locale strings.";
    homepage = "https://github.com/m1/go-localize";
    license = licenses.mit;
    # maintainers = with maintainers; [ chekoopa ];
    platforms = platforms.linux;
  };
}
