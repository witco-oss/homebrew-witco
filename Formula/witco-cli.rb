require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.5.0"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.5.0/witctl-v0.5.0-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "d64525a6d9178a9edd6f0ffc90fee7ead99171c5d6d271be7acfb26f94cc05a5"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.5.0/witctl-v0.5.0-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "04cc267c57ec6ef41f77c899689fac6a1f754c5ecc4b88b509e81e3119cbf044"
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
