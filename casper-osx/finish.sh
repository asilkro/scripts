#!/bin/sh

###############################################################################
# This script is a combination of a number of small common configuration commands/scripts.
#
# Recommended usage is running this after imaging before binding and handing out.
# Many of these can be set via configuration profiles for 10.9 and later. Unte
#
# Comment out anything not necessary or appropriate for your usage/environment.
# This should be run with sudo to make sure there is sufficient access.
###############################################################################

## Find WiFi port and power on device
WIFI=$(/usr/sbin/networksetup -listnetworkserviceorder | /usr/bin/awk -F'\\) ' '/Wi-Fi/ { printf $2 }')
wifiPort=`networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/,/Ethernet/' | awk 'NR==2' | cut -d " " -f 2`
networksetup -setairportpower $wifiPort on

## Adds the network below as preferred to enable autoconnect. Works with WEP/WPA/WPA2 networks.
# If you're using 802.1X and a user-specific name/PW set, comment this line out.
networksetup -addpreferredwirelessnetworkatindex en0 <networkname> 1 WPA2 <networkpassword>

# Disable pop up asking about using removable media/external drives as Time Machine backups
defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Set machine time zone - running systemsetup -listtimezones will give you the list in the correct format.
# America/Los_Angeles is PST, America/Chicago is CST and America/New_York is EST.
systemsetup -settimezone America/Los_Angeles

# Enable Network Time sync
# Recommend setting to domain controller or DC time sync server to avoid issues.
systemsetup -setusingnetworktime on

# Define Network Time server
systemsetup -setnetworktimeserver time.apple.com

# Disable save state on logout. This can prevent long login times if users do not quit every application prior to logout/shutdown.
/usr/bin/defaults write com.apple.loginwindow 'TALLogoutSavesState' -bool false

# Enable SSH for remote management - used by Casper remote but can be triggered via policy later.
# While useful, this enables SSH for all users and is a security concern for some organizations.
# /usr/sbin/systemsetup -setremotelogin on

# Turn off DS_Store file creation on network volumes.
# This isn't functionally necessary but helpful for housekeeping.
defaults write /System/Library/User\ Template/English.lproj/Library/Preferences/com.apple.desktopservices DSDontWriteNetworkStores true

# Enable expanded information via clock to see IP/Host Name/OS version including build.
defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Sets login screen to username and password instead of default name and picture to click on.
# This will require users to either type their full name or learn their OS shortname.
defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

# Make default printing view the expanded/useful view - recommended for all environments
defaults write /Library/Preferences/.GlobalPreferences PMPrintingExpandedStateForPrint2 -bool TRUE

# Disable Fast User Switching (including hiding from the menubar)
# Recommend commenting out for shared/lab computers, using for personal machines.
defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool FALSE

# Modify Mouse/Trackpad scrolling direction. Comment out to leave as Apple defaults (inverse from Windows default).
# This can probably be skipped and modified on a per user basis.
defaults write /System/Library/User\ Template/English.lproj/Library/Preferences/.GlobalPreferences.plist com.apple.swipescrolldirection -boolean FALSE

# Remove iLife apps - this can free up some space and can discourage users from syncing personal devices to company assets.
if [[ -d /Applications/Photos.app ]]; then
	
	rm -rf /Applications/GarageBand.app
	rm -rf /Applications/iMovie.app
	rm -rf /Applications/iPhoto.app
	rm -rf /Applications/Photos.app

fi

# Control Panel Authorization modifications
# Allows users to modify date/time (for time zones), printers, and energy saver settings.
security authorizationdb write system.preferences allow
security authorizationdb write system.preferences.datetime allow
security authorizationdb write system.preferences.printing allow
security authorizationdb write system.preferences.energysaver allow

# Reset Apple Software Update preferences and check for updates
/bin/rm /Library/Preferences/com.apple.SoftwareUpdate.plist
softwareupdate -iav

# Reboot computer - this allows any updates requiring restarts to install.
shutdown -r now
