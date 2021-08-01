{ stdenv, lib, fetchFromGitHub, buildGoModule
, git
}:

buildGoModule rec {
  pname = "mycorrhiza";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "bouncepaw";
    repo = "mycorrhiza";
    rev = "v${version}";
    sha256 = "1rlqcvc0jnx8nf6iwh67nnwl61nfk6cb2lhyvjy1fsa87lc0ql62";
    fetchSubmodules = true;
  };

  vendorSha256 = "1gqr1nwakjfkq3fkvxm21j85k4nf8329kba9chn8xmzm35yhrdfm"; 

  subPackages = [ "." ]; 

  propagatedBuildInputs = [ git ];

  meta = with lib; {
    description = "Filesystem and git-based wiki engine written in Go using mycomarkup as its primary markup language";
    homepage = "https://github.com/bouncepaw/mycorrhiza";
    license = licenses.agpl3;
    # maintainers = with maintainers; [ bouncepaw chekoopa ];
    platforms = platforms.linux;
  };
}
