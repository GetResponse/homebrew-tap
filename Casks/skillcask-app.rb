cask "skillcask-app" do
  version "0.10.4"
  sha256 "556488af232dffce9fd353831b479c53a0b9d21236ec6b495baf8a203f60f9c2"

  url "https://github.com/GetResponse/skillcask/releases/download/v#{version}/Skillcask-#{version}-macos-universal.zip"
  name "Skillcask"
  desc "Desktop app for the skillcask package manager for agent skills"
  homepage "https://github.com/GetResponse/skillcask"

  depends_on formula: "puniserv/tap/skillcask"
  depends_on macos: :sonoma

  app "Skillcask.app"

  zap trash: [
    "~/Library/Preferences/io.github.puniserv.skillcask.plist",
    "~/Library/Saved Application State/io.github.puniserv.skillcask.savedState",
  ]
end
