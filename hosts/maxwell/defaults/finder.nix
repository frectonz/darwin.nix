let
  # default look of icon view for folders that have no saved view of their own
  viewSettings = {
    IconViewSettings = {
      # keep icons sorted by name and flowing to fill the window
      arrangeBy = "name";
      gridSpacing = 54;
      iconSize = 64;
      labelOnBottom = true;
      showIconPreview = true;
      showItemInfo = false;
      textSize = 12;
    };
  };
in
{
  system.defaults = {
    NSGlobalDomain = {
      # always show file extensions
      AppleShowAllExtensions = true;
      # open save dialogs in the expanded view with the folder tree
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      # save dialogs default to local disk, not iCloud Drive
      NSDocumentSaveNewDocumentsToCloud = false;
    };

    finder = {
      # show dotfiles
      AppleShowAllFiles = true;
      # path bar at the bottom of the window
      ShowPathbar = true;
      # item count and free space at the bottom of the window
      ShowStatusBar = true;
      # search the current folder instead of the whole Mac
      FXDefaultSearchScope = "SCcf";
      # no "are you sure" when changing a file extension
      FXEnableExtensionChangeWarning = false;
      # full path in the window title
      _FXShowPosixPathInTitle = true;
      # folders listed before files
      _FXSortFoldersFirst = true;
      # new windows open at the home folder
      NewWindowTarget = "Home";
    };

    CustomUserPreferences = {
      "com.apple.finder" = {
        # hide tags from the toolbar menu and collapse them in the sidebar
        ShowRecentTags = false;
        SidebarTagsSctionDisclosedState = false;
        # keep the Locations section of the sidebar expanded
        SidebarDevicesSectionDisclosedState = true;
        # apply the icon view above to new windows, the defaults template, and the Desktop
        StandardViewSettings = viewSettings;
        FK_StandardViewSettings = viewSettings;
        DesktopViewSettings = viewSettings;
      };
      # do not litter network shares and USB drives with .DS_Store files
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
    };
  };
}
