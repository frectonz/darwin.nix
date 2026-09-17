# Delete macOS defaults that a previous generation wrote and this one no longer sets.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.system) primaryUser;
  home = config.users.users.${primaryUser}.home or "/Users/${primaryUser}";

  # from nix-darwin/modules/system/defaults-write.nix
  systemDomains = {
    loginwindow = [ "/Library/Preferences/com.apple.loginwindow" ];
    smb = [ "/Library/Preferences/SystemConfiguration/com.apple.smb.server" ];
    SoftwareUpdate = [ "/Library/Preferences/com.apple.SoftwareUpdate" ];
  };
  userDomains = {
    ".GlobalPreferences" = [ ".GlobalPreferences" ];
    NSGlobalDomain = [ "-g" ];
    LaunchServices = [ "com.apple.LaunchServices" ];
    menuExtraClock = [ "com.apple.menuextra.clock" ];
    dock = [ "com.apple.dock" ];
    finder = [ "com.apple.finder" ];
    hitoolbox = [ "com.apple.HIToolbox" ];
    iCal = [ "com.apple.iCal" ];
    magicmouse = [
      "com.apple.AppleMultitouchMouse"
      "com.apple.driver.AppleMultitouchMouse.mouse"
    ];
    screencapture = [ "com.apple.screencapture" ];
    screensaver = [ "com.apple.screensaver" ];
    spaces = [ "com.apple.spaces" ];
    trackpad = [
      "com.apple.AppleMultitouchTrackpad"
      "com.apple.driver.AppleBluetoothMultitouch.trackpad"
    ];
    universalaccess = [ "com.apple.universalaccess" ];
    ActivityMonitor = [ "com.apple.ActivityMonitor" ];
    WindowManager = [ "com.apple.WindowManager" ];
    controlcenter = [ "${home}/Library/Preferences/ByHost/com.apple.controlcenter" ];
  };

  groups = config.system.defaults // {
    dock = removeAttrs config.system.defaults.dock [ "expose-group-by-app" ];
  };

  keysOf = group: lib.attrNames (lib.filterAttrs (_: value: value != null) group);
  line =
    scope: domain: key:
    "${scope}\t${domain}\t${key}";

  fromGroups =
    scope: table:
    lib.concatLists (
      lib.mapAttrsToList (
        name: domains: lib.concatMap (domain: map (line scope domain) (keysOf groups.${name})) domains
      ) table
    );

  fromCustom =
    scope: prefs:
    lib.concatLists (lib.mapAttrsToList (domain: group: map (line scope domain) (keysOf group)) prefs);

  managedKeys =
    fromGroups "system" systemDomains
    ++ fromGroups "user" userDomains
    ++ fromCustom "system" groups.CustomSystemPreferences
    ++ fromCustom "user" groups.CustomUserPreferences;

  manifest = pkgs.writeText "managed-defaults" (lib.concatMapStrings (l: l + "\n") managedKeys);

  user = lib.escapeShellArg primaryUser;
in
{
  system.activationScripts.extraActivation.text = lib.mkAfter ''
    previousManifest=/var/db/nix-darwin/managed-defaults
    currentManifest=${manifest}

    deleteManagedDefault() {
      local scope=$1 domain=$2 key=$3
      echo >&2 "  $domain $key"
      if [[ $scope == user ]]; then
        launchctl asuser "$(id -u -- ${user})" sudo --user=${user} -- \
          defaults delete "$domain" "$key" 2>/dev/null || true
      else
        defaults delete "$domain" "$key" 2>/dev/null || true
      fi
    }

    if [[ -f $previousManifest ]]; then
      staleLines=$(grep -Fxv -f "$currentManifest" "$previousManifest" || true)

      if [[ -n $staleLines ]]; then
        echo >&2 "resetting removed defaults..."
        while IFS=$'\t' read -r scope domain key; do
          deleteManagedDefault "$scope" "$domain" "$key"
        done <<< "$staleLines"

        if grep -q $'\tcom.apple.dock\t' <<< "$staleLines"; then
          echo >&2 "restarting Dock..."
          killall -qu ${user} Dock || true
        fi
      fi
    fi

    mkdir -p "$(dirname "$previousManifest")"
    install -m 0644 "$currentManifest" "$previousManifest"
  '';
}
