{ pkgs, ... }:
let
  postgresPort = 6543;
  postgresDb = "my_db";
  postgresUser = "my_db_admin";
  postgresPassword = "SeCuRe";
  postgresPkg = pkgs.postgresql_15;
in {

  scripts = {
    wipe_db.exec = "rm -Rf $PGDATA";
    db_connect.exec =
      "${postgresPkg}/bin/psql -d ${postgresDb} -U ${postgresUser} $@";
  };

  services = {
    postgres = {
      enable = true;
      package = postgresPkg;
      port = postgresPort;
      listen_addresses = "127.0.0.1";
      initialDatabases = [{ name = postgresDb; }];
      initialScript = ''
        CREATE ROLE ${postgresUser} WITH LOGIN SUPERUSER PASSWORD '${postgresPassword}';
      '';
    };
  };
}
