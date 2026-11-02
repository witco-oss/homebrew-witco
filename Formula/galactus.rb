require_relative "../lib/aws_s3_curl_download_strategy"

class Galactus < Formula
  desc "Kubernetes deployment orchestrator"
  homepage "https://github.com/cincpro/galactus"
  version "0.24.1"

  on_arm do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.1/galactus-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "5665bd6fa8b7bf07b7b7c2853367cb03446130277b22655e4e5f916b009bf938"
  end

  on_intel do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.1/galactus-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "71af717c5384d60f2051f1b30dd074134d4dde21c1bbb835fadb5eca09c71672"
  end

  depends_on "awscli"
  depends_on :macos => :monterey

  def install
    bin.install "galactus"

    # Clean up AWS config created by download strategy
    config_dir = Pathname.new(Dir.home) / ".homebrew-witco-cli"
    config_dir.rmtree if config_dir.exist?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/galactus --version")
  end
end
