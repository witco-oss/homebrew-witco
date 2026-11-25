require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.23.0"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.23.0/witctl-v0.23.0-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "41f64ca45b5eacb208baf2303aa1db3d3c3f50c9d6650dc05ae9e61f628d7c46"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.23.0/witctl-v0.23.0-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "f335eebaeabb8d4df01da13012394c300febbc9069d944429761a8b205e0c936"
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
