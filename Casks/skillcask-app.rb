cask "skillcask-app" do
  version "0.10.3"
  sha256 "377aed02835e03c19643f7d8caebf27698a5d50aba51dd2fec318b1244bef2d4"

  url "https://github.com/getresponse/skillcask/releases/download/v#{version}/Skillcask-#{version}-macos-universal.zip"
  name "Skillcask"
  desc "Desktop app for the skillcask package manager for agent skills"
  homepage "https://github.com/getresponse/skillcask"

  depends_on formula: "puniserv/tap/skillcask"
  depends_on macos: :sonoma

  app "Skillcask.app"

  zap trash: [
    "~/Library/Preferences/io.github.puniserv.skillcask.plist",
    "~/Library/Saved Application State/io.github.puniserv.skillcask.savedState",
  ]
end
