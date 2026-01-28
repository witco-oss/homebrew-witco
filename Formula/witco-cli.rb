require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.3.1"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.3.1/witctl-v0.3.1-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "7d635226505e17c6723de0d1a309fede9f0cf1bf7868eccd4de62d2acddc8993"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.3.1/witctl-v0.3.1-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "aac4617bb54701b0e67e1fe12a7068d6779e55650b046dcac07406dab58782ad"
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
