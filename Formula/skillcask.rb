class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/GetResponse/skillcask"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.14.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "b48bde83b7201c2e7604536d2cd910ae1b2e2d49922ace0350de81a455f45611"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.14.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "a94fede61f8cc48f54866233e34d2bf996d86dff9dabe9ee970334011dd4e23a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.14.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "77edfe078acd454954bfc643d97941f9abb207c6fec1855663bf46400ea6ed92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.14.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b4632a8338629f9a8be3beb0afefa4fb956631d7b6ff7c6a04d8e716d73264c6"
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
