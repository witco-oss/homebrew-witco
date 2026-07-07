require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.10.0"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.10.0/witctl-v0.10.0-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "0de1e2664119c626cb4684297ee6a7f6607f16e24f220b4993432a81eb9cbe58"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.10.0/witctl-v0.10.0-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "b715b5b619377ebb9a8562f7d224c8b26df48c26ff88cca3e69a936cb1cd2d8b"
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
