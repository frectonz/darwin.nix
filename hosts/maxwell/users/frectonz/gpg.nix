{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry_mac;
  };
  programs.gpg.enable = true;
  programs.fish.loginShellInit = "gpgconf --launch gpg-agent";

  # Don't store the GPG passphrase in the macOS keychain
  targets.darwin.defaults."org.gpgtools.common".UseKeychain = false;
}
