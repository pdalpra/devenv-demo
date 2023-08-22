{ pkgs, ... }:

let npm = pkgs.nodePackages.npm;
in {
  enterShell = ''
    echo "Welcome to my awesome dev env 🚀"
  '';

  scripts = {
    sneaky-movies.exec =
      "${pkgs.inetutils}/bin/telnet telehack.com | ${pkgs.lolcat}/bin/lolcat";
  };

  packages = with pkgs; [ nixpkgs-fmt npm scala-cli ];

  languages = {
    java = {
      enable = true;
      jdk.package = pkgs.jdk20;
    };
    javascript = {
      enable = true;
      package = pkgs.nodejs_18;
      npm.install.enable = true;
    };
  };

  processes.server.exec = "${npm}/bin/npm run server";

  pre-commit.hooks = { nixfmt.enable = true; };
}
