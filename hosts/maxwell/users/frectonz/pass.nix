{ config, ... }:
{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      PASSWORD_STORE_KEY = "9CFA458945B7094F";
    };
  };
}
