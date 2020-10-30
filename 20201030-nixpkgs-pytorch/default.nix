let
  channel = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8c7203e.tar.gz";
    sha256 = "0skf7ra1pbqvfh1lv1rlxld0knvxszciyf30n97925frgwkcqbr4";
  };

  pkgs = import channel {};

in with pkgs; stdenv.mkDerivation {
  name = "myapp";
  src = ./.;

  buildInputs = [
    cmake
    python3Packages.pytorchWithoutCuda
  ];

}

