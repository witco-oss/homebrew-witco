require_relative "../lib/aws_s3_curl_download_strategy"

class Galactus < Formula
  desc "Kubernetes deployment orchestrator"
  homepage "https://github.com/cincpro/galactus"
  version "0.24.4"

  on_arm do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.4/galactus-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "0649bdb122cfa99b45012c468ce80d3953df8dd07fb3f062beaee1dfcfdfe4d1"
  end

  on_intel do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.4/galactus-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "bf66a284e89e15b84b3963470a3edfabc7d6a81cdbf4dad4eaf316d0261abcc8"
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
