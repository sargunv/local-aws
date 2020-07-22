let
  pkgs = import ./nix { };

  bootstrap = pkgs.writeScript "bootstrap" ''
    ${pkgs.cowsay}/bin/cowsay "Welcome on my magic meadow"
  '';

in pkgs.mkShell rec {
  NAME = "playground";
  NIX_SHELL_NAME = "${NAME}#λ";

  buildInputs = with pkgs; [
    cowsay
    hello
    bashInteractive
    nixfmt
    python38
    pulumi-bin
  ];

  shellHook = ''
    ${bootstrap}
  '';
}
