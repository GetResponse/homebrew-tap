cask "skillcask-app" do
  version "0.10.6"
  sha256 "6b261f02eb97da262793835a19f2da51e5d6e24e5e9ce4c94c5960d77aff2a8e"

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
