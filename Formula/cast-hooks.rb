class CastHooks < Formula
  desc "13 Claude Code hook scripts — observability, safety guards, and agent dispatch"
  homepage "https://github.com/ek33450505/cast-hooks"
  url "https://github.com/ek33450505/cast-hooks/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "7677d5971390677a676763d9bb663904534bde1090f94e258796bb15be2134b2"
  license "MIT"

  def install
    libexec.install Dir["scripts/*"]
    (libexec/"config").install Dir["config/*"]
    (libexec/"VERSION").write(File.read("VERSION"))
    prefix.install "VERSION"

    inreplace "bin/cast-hooks",
              'CAST_HOOKS_DIR=""',
              "CAST_HOOKS_DIR=\"#{libexec}\""

    inreplace "bin/cast-hooks",
              /CH_VERSION="\$\(cat.*\|\| echo .unknown.\)"/,
              "CH_VERSION=\"#{version}\""

    bin.install "bin/cast-hooks"
  end

  def caveats
    <<~EOS
      Install hooks to ~/.claude/scripts/ and merge settings:
        cast-hooks install

      Check which hooks are active:
        cast-hooks status

      List all available hooks:
        cast-hooks list
    EOS
  end

  test do
    system "#{bin}/cast-hooks", "--version"
  end
end
