{ stdenv, lib, fetchFromGitHub, buildGoModule
, makeWrapper, git
}:

let
  devBuild = false;
in
buildGoModule rec {
  pname = "mycorrhiza";
  version = if devBuild then "1.5.1a" else "1.5.0";

  src = if devBuild then ../mycorrhiza else fetchFromGitHub {
    owner = "bouncepaw";
    repo = "mycorrhiza";
    rev = "v${version}";
    sha256 = "1rlqcvc0jnx8nf6iwh67nnwl61nfk6cb2lhyvjy1fsa87lc0ql62";
    fetchSubmodules = true;
  };

  vendorSha256 = if devBuild 
    then "1br1p8cnyv2xpwnld3ydd87zxbdwl962f6yww8i8xbsm7881bl0d"
    else "1gqr1nwakjfkq3fkvxm21j85k4nf8329kba9chn8xmzm35yhrdfm";
  
  subPackages = [ "." ]; 

  nativeBuildInputs = [ makeWrapper ];
  propagatedBuildInputs = [ git ];

  postInstall = ''
    wrapProgram $out/bin/mycorrhiza \
      --set PATH /bin:${lib.makeBinPath [ git ]}
  '';

  meta = with lib; {
    description = "Filesystem and git-based wiki engine written in Go using mycomarkup as its primary markup language";
    homepage = "https://github.com/bouncepaw/mycorrhiza";
    license = licenses.agpl3;
    # maintainers = with maintainers; [ bouncepaw chekoopa ];
    platforms = platforms.linux;
  };
}
