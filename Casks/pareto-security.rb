﻿cask "pareto-security" do
  version "1.7.29"
  sha256 "7c830eb8edf706c21501e080f6f4ccf652ee96cfaba0d7c013b79af06c29809d"

  url "https://github.com/ParetoSecurity/pareto-mac/releases/download/#{version}/ParetoSecurity.dmg"
  name "Pareto Security"
  desc "Automatically audit your Mac for basic security hygiene."
  homepage "paretosecurity.com"

  depends_on macos: ">= :sierra"

  app "Pareto Security.app"

  livecheck do
    url :url
    strategy :github_latest
  end

end