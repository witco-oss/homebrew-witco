require_relative "../lib/aws_s3_curl_download_strategy"

class Galactus < Formula
  desc "Kubernetes deployment orchestrator"
  homepage "https://github.com/cincpro/galactus"
  version "0.23.2"

  on_arm do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.23.2/galactus-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "7e555d31b874b5e65add31c2b14979b910fc96cdfda7c837556e393c18b6e02d"
  end

  on_intel do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.23.2/galactus-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "d3f31ce07c98a85ea5e132900a0c22642aee389d3103651c1b6c61b1fb6144a3"
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
