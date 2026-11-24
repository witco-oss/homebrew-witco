require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.22.1"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.22.1/witctl-v0.22.1-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "53a852a09355111f7ceae73dab9bd39c283949ad68bc849027fb9a0f6e9b4d9d"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.22.1/witctl-v0.22.1-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "260ab06944175243e32813145d46f4483bdc8ee92b0376a592c1a16c541f68ae"
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
