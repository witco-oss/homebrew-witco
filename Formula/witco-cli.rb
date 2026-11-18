require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.21.1"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.21.1/witctl-v0.21.1-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "c9897b77953bd0d0e2915eb1e9dedf8e906e74f0da01f21c3fdff89cce507ec4"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.21.1/witctl-v0.21.1-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "14dc9b8678081d3585a8580a1e0c95af0e48b0f3c10e071183aa8ad010034bd3"
  end

  depends_on "awscli"
  depends_on :macos => :monterey

  def install
    bin.install "witctl"

    # Clean up AWS config created by download strategy
    config_dir = Pathname.new(Dir.home) / ".homebrew-witco-cli"
    config_dir.rmtree if config_dir.exist?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/witctl --version")
  end
end
