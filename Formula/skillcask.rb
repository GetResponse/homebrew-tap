class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/GetResponse/skillcask"
  version "0.10.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.10.4/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "434815d228fe9c86ffd7dcfdc07e9e46214a22ef8c70f08aadb37084e1af06b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.10.4/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "394dfed03a6030609856742970f56663c9b784dd6be569469ddfca8208631e74"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.10.4/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "58c1503596d4a4bbaf584baa163766dbe71f3f29c62a1c340c9528695449614f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.10.4/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2373e36cb4af568511fd45bb9640b339e5c542bf7c0252f9e8992492a87db98c"
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
