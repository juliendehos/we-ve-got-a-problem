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

in with pkgs; stdenv.mkDerivation {
  name = "myapp";
  src = ./.;

  buildInputs = [
    cmake
    libtorch-bin
    cudatoolkit
    cudnn
    linuxPackages.nvidia_x11
  ];

}

