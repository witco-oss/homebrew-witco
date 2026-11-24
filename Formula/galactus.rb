require_relative "../lib/aws_s3_curl_download_strategy"

class Galactus < Formula
  desc "Kubernetes deployment orchestrator"
  homepage "https://github.com/cincpro/galactus"
  version "0.24.3"

  on_arm do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.3/galactus-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "dd4818cc53a940ef6b98b9a2b72d80b651f7e6c224980d8db6874afb763e9cf7"
  end

  on_intel do
    url "https://mgt-wc-galactus-releases.s3.us-east-1.amazonaws.com/galactus-v0.24.3/galactus-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "0850090cd57a6b946430d5e8a519700dce6ebfd4f6bfc3531464a2023bd95ea3"
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
