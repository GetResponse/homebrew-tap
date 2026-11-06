cask "skillcask-app" do
  version "0.12.0"
  sha256 "a4951e9c0f739faeeb0cbd91b4565f0fc72d2cf6b26bbce74b5c39e66c92a83c"

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
