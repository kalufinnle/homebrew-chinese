cask "julia-cn" do
  arch arm: "aarch64", intel: "x64"

  version "1.8.3"
  sha256 arm:   "829d57ab4c3ef02c714e3c73d47e97ddd7dd422043f85e1e34a0690552a494f5",
         intel: "1544909bf670e4b276b369beaa52995017398969efd89b71ce07ac11c9635eb1"

  url "https://mirrors.bfsu.edu.cn/julia-releases/bin/mac/#{arch}/#{version.major_minor}/julia-#{version}-mac#{arch.delete_prefix("x")}.dmg",
      verified: "mirrors.bfsu.edu.cn/"
  name "Julia"
  desc "Programming language for technical computing"
  homepage "https://julialang.org/"

  livecheck do
    url "https://julialang.org/downloads/"
    regex(/href=.*?julia[._-]v?(\d+(?:\.\d+)+)[._-]mac#{arch.delete_prefix("x")}\.dmg/i)
  end

  conflicts_with cask: "julia"

  app "Julia-#{version.major_minor}.app"
  binary "#{appdir}/Julia-#{version.major_minor}.app/Contents/Resources/julia/bin/julia"

  zap trash: [
    "~/.julia",
    "~/Library/Preferences/julia.plist",
  ]
end
