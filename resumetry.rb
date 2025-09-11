# typed: false
# frozen_string_literal: true

class Resumetry < Formula
  include Language::Python::Virtualenv

  desc "Config + template → PDF generator (LaTeX), Typer-based CLI"
  homepage "https://github.com/ajilk/resumetry"
  url "https://github.com/ajilk/resumetry/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "2a3b0625a776cfa38e577cbbfb7760a271e1722165b85fb6ec80b6b32e09d31d"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    # basic invocation should show help
    assert_match "Usage:", shell_output("#{bin}/resumetry --help")
  end
end
