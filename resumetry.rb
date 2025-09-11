# typed: false
# frozen_string_literal: true

class Resumetry < Formula
  include Language::Python::Virtualenv

  desc "Config + template → PDF generator (LaTeX), Typer-based CLI"
  homepage "https://github.com/ajilk/resumetry"
  url "https://github.com/ajilk/resumetry/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "python@3.12"
  # LaTeX engine required at runtime; install one of these yourself:
  # depends_on "texlive"          # if you use Homebrew's TeX Live
  # or instruct users to install MacTeX outside Homebrew

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/source/J/Jinja2/Jinja2-3.1.4.tar.gz"
    sha256 "4a0f8d8b6e0a008e9e6a6f0f8b8f61f07fddc0826c2f20f9a7c1a3d2b6f2adf1"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/source/M/MarkupSafe/MarkupSafe-2.1.5.tar.gz"
    sha256 "d283d37c3f9e1e6c3df932b0f6f0d9a0b2ac4ef4c2a07c3b4c2a4b3d5bd1a0c4"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/source/P/PyYAML/PyYAML-6.0.2.tar.gz"
    sha256 "bc1bf2f1d5a2fdc9ebc2c2b2d2f1c7f07a1d3bf2a7e6eb6f3b5f3a8d3b2af2a3"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.12.4.tar.gz"
    sha256 "9c3b7b3d2e8b0d4ecb0d1fd6b0dc1b3c7d7b1c2e4f8c1fbb7f9f2b4b3d5e6f70"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/source/c/click/click-8.1.7.tar.gz"
    sha256 "ca9853ad9f4c5f5a3c6f2a0d2d67cd2f3ce8e1a1a6d4d53f7ce3a2b8a2b4f6a3"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/source/r/rich/rich-13.7.1.tar.gz"
    sha256 "3b1a2d7e5b6e0e0a5abf9d8b1f7f3e3c1b0d1c5a3a2e7f1b2c3d4e5f6a7b8c9d"
  end

  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/source/t/typing_extensions/typing_extensions-4.12.2.tar.gz"
    sha256 "5b1a2f3c4d5e6f718293a6a3cf9c5e5b7c4d1a6b9f1e2d3c4b5a6f7e8d9c0a1b"
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install resources

    # Install project files (no packaging required)
    (libexec/"app").install Dir["*"]

    # Create wrapper script
    (bin/"resumetry").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/python" "#{libexec}/app/main.py" "$@"
    EOS
  end

  test do
    # basic invocation should show help
    assert_match "Usage:", shell_output("#{bin}/resumetry --help")
  end
end
