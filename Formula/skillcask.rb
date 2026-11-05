class Skillcask < Formula
  desc "A lockfile-first package manager for AI agent skills (SKILL.md), backed by Composer repositories"
  homepage "https://github.com/GetResponse/skillcask"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.12.0/skillcask-aarch64-apple-darwin.tar.xz"
      sha256 "593492f8757a88b7c6166853960bda51c05d2401c6e9de23ea673a99868806fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.12.0/skillcask-x86_64-apple-darwin.tar.xz"
      sha256 "0a8c3e1dc684e67e94f7dca3a62a1ec1783128698cf8f51f3f55ed688ea14524"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.12.0/skillcask-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3cf00c8bd28248584f6df7d34aa31a09c3dfe7d16d0781e55d879fef5fe8132b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/GetResponse/skillcask/releases/download/v0.12.0/skillcask-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a8558a6d38143205f7565195ee72aca5073ae40d1b0791c9261c9aee6b031dad"
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
