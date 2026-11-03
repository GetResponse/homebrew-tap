class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/getresponse/skillcask"
  version "0.10.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/getresponse/skillcask/releases/download/v0.10.3/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "ae0b0a94afbfe64a096f2c61597745e31a8e1bf616694119b011d2d8dcd061a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/getresponse/skillcask/releases/download/v0.10.3/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "6a00f014ce5cfff056bfd96053cca9ad5eaa6945ca483be490e90cacbd18f6ff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/getresponse/skillcask/releases/download/v0.10.3/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "73392a28e6527bf205ba80a25e0863f5f0a75cc3ad6b505c2ac2f46e21811eb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/getresponse/skillcask/releases/download/v0.10.3/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4efd9f1af2b926428ee5a534dd6c70a40868f43d2dacc64a4a3d21af7b1ec229"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "skillcask"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "skillcask"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "skillcask"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "skillcask"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
