class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/GetResponse/skillcask"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.13.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "c14ee392a0ea24c6a404af460a6edd4eac6b5b2400579a1d11c7431c9887a38f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.13.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "7c788fb7053c036aa9f67984db3cd1a8d46450aef1adf84a1fc4bb1c8b7d9c2f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.13.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9326e601357b12aedddd987630a539bc56963f4e00e738dd231610ab86f3c606"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.13.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cc22508a075a9bd78e12b174f2ebda4e95f65be5227149d6e4b56d49da07ba3d"
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
