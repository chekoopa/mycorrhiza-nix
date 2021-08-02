{ config, lib, pkgs, ... }:

# TODO: add address option (-listen-addr string)
# TODO? multiinstancing (systemd service generation?)
# TODO: nixos module with dedicated myco user and proper settings

with lib;

let 

  cfg = config.services.mycorrhiza;
  homeDir = config.home.homeDirectory;

in
{
  # meta.maintainers = [ maintainers.bouncepaw maintainers.chekoopa ];

  options = {
    services.mycorrhiza = {
      enable = mkEnableOption "Mycorrhiza filesystem and git-based wiki engine";

      package = mkOption {
        type = types.package;
        default = pkgs.mycorrhiza;
        defaultText = literalExample "pkgs.mycorrhiza";
        description = "Mycorrhiza package to use.";
      };

      gitPackage = mkOption {
        type = types.package;
        default = pkgs.git;
        defaultText = literalExample "pkgs.git";
        description = "Git package to use.";
      };

      wikiPath = mkOption {
        type = types.str;
        default = "${homeDir}/.mycorrhiza";
        defaultText = literalExample "${homeDir}/.mycorrhiza";
        example = literalExample "${homeDir}/wiki";
        description = ''
          Literal path to wiki. Data is created and initialized 
          automatically if path does not exists.
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      systemd.user.services = {
        mycorrhiza = {
          Unit = {
            Description =
              "Mycorrhiza - filesystem and git-based wiki engine";
            After = [ "network.target" ];
          };

          Service = {
            ExecStart =
              "${cfg.package}/bin/mycorrhiza ${cfg.wikiPath}";
            Restart = "on-failure";
            Environment = "PATH=${cfg.gitPackage}/bin:/usr/bin:/bin";
            # system variant is: path = [ cfg.gitPackage ];
          };

          Install = { WantedBy = [ "default.target" ]; };
        };
      };
    })
  ];
}
