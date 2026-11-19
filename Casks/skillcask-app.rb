cask "skillcask-app" do
  version "0.14.0"
  sha256 "2516b45ddef4c41cab8d28afe8f69c5b086928f025900afda04d9f1da7c64468"

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
