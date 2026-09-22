require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.14.1"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.14.1/witctl-v0.14.1-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "42e4405066e1316463c0f1d8dc00db87e3460caa746c43c02c77a620fd949436"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.14.1/witctl-v0.14.1-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "063dd04df78b6490f9beb7958c4d83e81d1ce334b48fec0128ab28932bdc854b"
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
