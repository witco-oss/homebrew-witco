require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.19.1"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.19.1/witctl-v0.19.1-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "f0231d419a2ad7201ff37f58afa5dd0024432cd6fa09701cf9a9cdf0b85eae7e"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.19.1/witctl-v0.19.1-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "44fb19b3772b49582f6f1404e8a6402f8c9a0890751a8bb91908f7b20ba1719f"
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
