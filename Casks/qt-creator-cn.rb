cask "qt-creator-cn" do
  version "8.0.2"
  sha256 "da57f709e34ac7eb1281ed2db74eebc29364eb5f9125d3374b1a08572925d254"

  url "https://mirrors.bfsu.edu.cn/qt/official_releases/qtcreator/#{version.major_minor}/#{version}/qt-creator-opensource-mac-x86_64-#{version}.dmg",
      verified: "mirrors.bfsu.edu.cn/qt/official_releases/qtcreator/"
  name "Qt Creator"
  desc "IDE for application development"
  homepage "https://www.qt.io/developers/"

  # It's necessary to check within a major/minor version directory
  # (fetching an additional page) to obtain the full version.
  livecheck do
    url "https://download.qt.io/official_releases/qtcreator/?C=M;O=D"
    strategy :page_match do |page|
      # These version directories can sometimes be empty, so this will check
      # directory pages until it finds versions
      page.scan(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i).lazy.map do |match|
        version_page = Homebrew::Livecheck::Strategy.page_content(url.sub("/?", "/#{match[0]}/?"))
        next if version_page[:content].blank?

        versions = version_page[:content].scan(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i).map(&:first)
        next if versions.blank?

        versions
      end.compact_blank.first
    end
  end

  depends_on macos: ">= :sierra"

  app "Qt Creator.app"

  zap trash: [
    "~/Library/Preferences/com.qtproject.QtCreator.plist",
    "~/Library/Preferences/org.qt-project.qtcreator.plist",
    "~/Library/Saved Application State/org.qt-project.qtcreator.savedState",
  ]
end