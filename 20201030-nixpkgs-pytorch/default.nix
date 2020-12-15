let
  channel = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz";
    #url = "https://github.com/NixOS/nixpkgs/archive/0b875aa.tar.gz";
    #sha256 = "sha256:1pr56w356s67hnmjjarbzpmv1hwb0rd9nq6rcnxb3dxss5r3i5hr";
  };

  pkgs = import ../../nixpkgs {};
  #pkgs = import channel {};

in with pkgs; stdenv.mkDerivation {
  name = "myapp";
  src = ./.;

  buildInputs = [
    cmake
    python3Packages.pytorchWithoutCuda
  ];

}

