{ pkgs, inputs, ... }:

let
  parts = inputs.devenv-parts.lib;
  npm = pkgs.nodePackages.npm;
  postgres = parts.postgres {
    package = pkgs.postgresql_15;
    port = 6543;
    db = "my_db";
    user = "my_db_admin";
    password = "SeCuRe";

  };
  env = {
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
  };
in parts.mergeAll [ postgres env ]
