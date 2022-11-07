cask "blender-cn" do
  arch arm: "arm64", intel: "x64"

  version "3.3.1"
  sha256 arm:   "e4a19540ad98222ebb23115fb1fdac04ba04501f4d8aa3d8b82c61d8757e1cd6",
         intel: "94916e019d6609be2515f3d42f00df1749da4e6e6211d89ec64e8509dc8fbbbc"

  url "https://mirror.nju.edu.cn/download/Blender/blender-#{version}-macos-#{arch}.dmg"
  name "Blender"
  desc "3D creation suite"
  homepage "https://www.blender.org/"

  livecheck do
    url "https://www.blender.org/download/"
    regex(%r{href=.*?/blender[._-]v?(\d+(?:\.\d+)+)[._-]macos[._-]#{arch}\.dmg}i)
  end

  conflicts_with cask: ["homebrew/cask-versions/blender-lts",
                        "blender"]
  depends_on macos: ">= :high_sierra"

  app "Blender.app"
  # shim script (https://github.com/Homebrew/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/blender.wrapper.sh"
  binary shimscript, target: "blender"

  preflight do
    # make __pycache__ directories writable, otherwise uninstall fails
    FileUtils.chmod "u+w", Dir.glob("#{staged_path}/*.app/**/__pycache__")

    File.write shimscript, <<~EOS
      #!/bin/bash
      '#{appdir}/Blender.app/Contents/MacOS/Blender' "$@"
    EOS
  end

  zap trash: [
    "~/Library/Application Support/Blender",
    "~/Library/Saved Application State/org.blenderfoundation.blender.savedState",
  ]
end
