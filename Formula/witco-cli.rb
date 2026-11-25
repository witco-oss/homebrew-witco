require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.24.0"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.24.0/witctl-v0.24.0-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "e10ed4f508e5c61ccbf9cc35acfacbec84878c10b4260b11041ab3c3415fa10e"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.24.0/witctl-v0.24.0-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "cc1d632818a6de147cbc45df2c25212e4cd3c04418440334f21cfcfa59110d3c"
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
