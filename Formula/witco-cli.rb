require_relative "../lib/aws_s3_curl_download_strategy"

class WitcoCli < Formula
  desc "CLI tool for Witco operations"
  homepage "https://github.com/cincpro/witco-cli"
  version "0.4.2"

  on_arm do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.4.2/witctl-v0.4.2-aarch64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "da82ac44d803ec3a950b64625cd0286e86700f9b5ed5b55914606e8fae49447f"
  end

  on_intel do
    url "https://mgt-wc-geekbot-cli-releases.s3.us-east-1.amazonaws.com/v0.4.2/witctl-v0.4.2-x86_64-apple-darwin.tar.gz", using: AwsS3CurlDownloadStrategy
    sha256 "01a0a3d0c4272091644ca95882e198ff2e8738ef5efd312159e13d7c07960be5"
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
