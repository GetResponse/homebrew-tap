class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/GetResponse/skillcask"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.11.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "96cb424588656d44035852d5a343308623aca1cbcf930639b191f02d17f26092"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.11.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "144a009a4b18f96a3cf4cdd3c94c7674d535c57abc7e232bb08de406c99e4e60"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.11.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dceeeee90ccc158230550d887a0b038ac3b623558d5c72cca38b4cba236d8eec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.11.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5cdfd2d1af19c01a34709d3aa0b57abea271b06adea0112c956a85f343ea4914"
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
