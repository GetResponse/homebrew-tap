cask "skillcask-app" do
  version "0.11.0"
  sha256 "1a3259ced38c45f0e60bec1dd698f820cebb48312f7187e8ee5482fb42cbba7c"

  url "https://github.com/GetResponse/skillcask/releases/download/v#{version}/Skillcask-#{version}-macos-universal.zip"
  name "Skillcask"
  desc "Desktop app for the skillcask package manager for agent skills"
  homepage "https://github.com/GetResponse/skillcask"

  depends_on formula: "getresponse/tap/skillcask"
  depends_on macos: :sonoma

  app "Skillcask.app"

  zap trash: [
    "~/Library/Preferences/io.github.puniserv.skillcask.plist",
    "~/Library/Saved Application State/io.github.puniserv.skillcask.savedState",
  ]
end
