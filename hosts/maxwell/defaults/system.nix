{
  # nix-darwin needs to know which user owns the per-user settings below
  system.primaryUser = "frectonz";

  # machine name shown in the terminal prompt, AirDrop, and Sharing
  networking.hostName = "maxwell";
  networking.computerName = "maxwell";

  # let sudo accept a fingerprint instead of a password
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    # no Guest user on the login screen
    loginwindow.GuestEnabled = false;
    # light during the day, dark at night
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    # no gap between windows when tiling them to the screen edges
    WindowManager.EnableTiledWindowMargins = false;
  };
}
