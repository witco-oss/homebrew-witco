require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.4.3"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.4.3/witctl-v0.4.3-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "7afbe49c90d2bb874e37770e761c24e7a46e32e72d8bdd81eed5e638ca9912f3"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.4.3/witctl-v0.4.3-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "d8ef8055b52a7f3c917459cbee0da0e298b60768cf500a2771a61baaddf1424a"
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
