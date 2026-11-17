require_relative "../lib/aws_s3_curl_download_strategy"

class Galactus < Formula
  desc "Kubernetes deployment orchestrator"
  homepage "https://github.com/cincpro/galactus"
  version "0.24.2"

  on_arm do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.2/galactus-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "0172df04702d9fc3629a2d345add1e2857a3f00375da3c22c762bad64da40ccd"
  end

  on_intel do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.2/galactus-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "9b843428cb4f0cd8086e0148e3e4e5a2de6b6f9a7da11bcb795fd907ed802b29"
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
