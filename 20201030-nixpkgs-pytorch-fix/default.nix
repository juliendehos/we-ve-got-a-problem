let
  channel = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/7e629cc.tar.gz";
    sha256 = "sha256:0wfvlr3zd6fcfa35aid5xnwjf12i5yy940f4ddcm9p3357pz8s62";
  };

  config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  pkgs = import channel { inherit config; };

in with pkgs; stdenv.mkDerivation rec {
  name = "myapp";
  src = ./.;

  buildInputs = [
    cmake
  ];

  preConfigure = ''
    export CXXFLAGS="-I${libtorch-bin.dev}/include -I${libtorch-bin.dev}/include/torch/csrc/api/include"
    export LDFLAGS="-L${libtorch-bin}/lib -L${pkgs.cudatoolkit}/lib -L${pkgs.cudnn}/lib -L${pkgs.linuxPackages.nvidia_x11}/lib -lc10 -ltorch_cpu -lc10_cuda -ltorch_cuda"
  '';

  shellHook = preConfigure;

}

