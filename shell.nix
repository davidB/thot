# { pkgs ? import <nixpkgs> {}}: # here we import the nixpkgs package store
# commit from https://status.nixos.org/
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/95ce0f52ec10.tar.gz") {}}:

pkgs.mkShell {               # mkShell is a helper function
  name="dev-environment";    # that requires a name
  # nativeBuildInputs is usually what you want -- tools you need to dev or to run
  nativeBuildInputs =  with pkgs; [
    # buildah
    dive
    # docker-slim # not well packaged so it crashes
    curl
    # rustc
    cargo
    # python38Full
    bazelisk
    bazel-buildtools
    #starship
  ];
  # buildInputs is for dependencies you'd need "at run time",
  # were you to to use nix-build not nix-shell and build whatever you were working on
  # buildInputs = [];
  
  # bash to run when you enter the shell
  shellHook = ''
    export DOCKER_BUILDKIT=1
    # source <(starship init bash --print-full-init)
  '';
}
