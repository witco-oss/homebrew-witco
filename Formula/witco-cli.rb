require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.20.0"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.20.0/witctl-v0.20.0-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "6b7ef79ba6b53a2f2f7cfaa71aec961afea796e042d132c5f065c420ea5ea690"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.20.0/witctl-v0.20.0-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "9b129ed2345441fde29ea6babf3f34bed9092abd86afd2ef1f214416e3e45429"
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
