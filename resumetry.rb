# typed: false
# frozen_string_literal: true

class Resumetry < Formula
  include Language::Python::Virtualenv

  desc "Config + template → PDF generator (LaTeX), Typer-based CLI"
  homepage "https://github.com/ajilk/resumetry"
  url "https://github.com/ajilk/resumetry/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d8f6d5bdfdabdf620892944bf99d9ecd44f48b61"
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
