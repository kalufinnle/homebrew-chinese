cask "gimp-cn" do
  arch arm: "arm64", intel: "x86_64"

  version "2.10.34"
  sha256 arm:   "5561a571fe8dfa176ca526939288322abfa4b5b084eda03013355313350aaf47",
         intel: "6d228b36eaa70be9dff81b37c3561dce2a62ff8c6fd55f6fc982457768e691da"

  url "https://mirrors.ustc.edu.cn/gimp/v#{version.major_minor}/osx/gimp-#{version}-#{arch}.dmg"
  name "GIMP development version"
  desc "Free and open-source image editor"
  homepage "https://www.gimp.org/"

  livecheck do
    url "https://www.gimp.org/downloads/devel/"
    strategy :page_match
    regex(%r{href=.*?/gimp[._-]v?(\d+(?:\.\d+)+)[._-]#{arch}\.dmg}i)
  end

  auto_updates true
  conflicts_with cask: ["gimp", "homebrew/cask-versions/gimp-dev"]

  app "GIMP.app"
  shimscript = "#{staged_path}/gimp.wrapper.sh"
  binary shimscript, target: "gimp"

  preflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      "#{appdir}/GIMP.app/Contents/MacOS/gimp" "$@"
    EOS
  end

  zap trash: [
    "~/Library/Application Support/Gimp",
    "~/Library/Preferences/org.gimp.gimp-#{version.major_minor}:.plist",
    "~/Library/Saved Application State/org.gimp.gimp-#{version.major_minor}:.savedState",
  ]
end
