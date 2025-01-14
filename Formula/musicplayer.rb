class Musicplayer < Formula
  desc "Extensible music server written in Rust"
  homepage "https://github.com/tsirysndr/music-player"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  arch = Hardware::CPU.arm? ? "aarch64" : "x86_64"

  if OS.mac?
    url "https://github.com/tsirysndr/music-player/releases/download/v0.2.0-alpha.10/music-player_v0.2.0-alpha.10_#{arch}-apple-darwin.tar.gz"
    if Hardware::CPU.intel?
      sha256 "2db0705db4a1905d95dfbaf01a656b0ebbdf4c663ebc0f97eb4b329f246ba1d5"
    else
      sha256 "6baaea9b96e2330771b8acc67fc9ee0e2f22263099a31ca6cded00547ee94fb0"
    end
  else
    url "https://github.com/tsirysndr/music-player/releases/download/v0.2.0-alpha.10/music-player_v0.2.0-alpha.10_x86_64-unknown-linux-gnu.tar.gz"
    sha256 "87ad6fdcc0281cbf7936d826b20a8ce42ad894ef3739b5df2ca6bcc20ec7a120"
  end

  def install
    bin.install "music-player"
  end
end
