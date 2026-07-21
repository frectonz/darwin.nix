{ config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "frectonz";
      user.email = "fraol0912@gmail.com";
      init.defaultBranch = "main";
      diff.external = "difft";
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
      http = {
        version = "HTTP/1.1";
        postBuffer = 1073741824; # 1GB buffer size
        lowSpeedLimit = 0;
        lowSpeedTime = 999999;
      };

    };
    signing = {
      key = "9CFA458945B7094F";
      signByDefault = true;
      format = "openpgp";
    };
  };
}
