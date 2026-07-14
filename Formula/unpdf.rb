# frozen_string_literal: true

# NativeAOT PDF-to-HTML command-line converter.
class Unpdf < Formula
  desc "Convert PDF documents to semantic HTML"
  homepage "https://github.com/erikbra/pdfbox-net"
  version "4.0.0-preview.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/erikbra/pdfbox-net/releases/download/unpdf-v4.0.0-preview.2/unpdf-4.0.0-preview.2-osx-arm64.tar.gz"
      sha256 "616482d6b5f9da93cb759cf011c4e5dc004f53d2929dfcefe260c8d58e29c787"
    end
    on_intel do
      url "https://github.com/erikbra/pdfbox-net/releases/download/unpdf-v4.0.0-preview.2/unpdf-4.0.0-preview.2-osx-x64.tar.gz"
      sha256 "66bc2059bf639fdc4684a07aa51483eaf74ec956b0794a9d84cc8f5c35ffceab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/erikbra/pdfbox-net/releases/download/unpdf-v4.0.0-preview.2/unpdf-4.0.0-preview.2-linux-arm64.tar.gz"
      sha256 "cdf3d2be67fbd93e390afc92c7bfc84424af63ce2981e167c5810370285e2031"
    end
    on_intel do
      url "https://github.com/erikbra/pdfbox-net/releases/download/unpdf-v4.0.0-preview.2/unpdf-4.0.0-preview.2-linux-x64.tar.gz"
      sha256 "a4530ba9b39e321a09a532172aebca9eac1036d670616363228c81ea7256d9f2"
    end
  end

  def install
    bin.install "unpdf"
    pkgshare.install "LICENSE.txt", "NOTICE.txt", "SIGNING.md", "VERSION", "artifact-manifest.json", "sbom.spdx.json"
  end

  test do
    require "base64"

    assert_match version.to_s, shell_output("#{bin}/unpdf --version")
    fixture = [
      "JVBERi0xLjQKJeLjz9MKMSAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4KZW5kb2JqCjIgMC",
      "BvYmoKPDwgL1R5cGUgL1BhZ2VzIC9Db3VudCAxIC9LaWRzIFszIDAgUl0gPj4KZW5kb2JqCjMgMCBvYmoKPDwgL1R5",
      "cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCAzMDAgMzAwXSAvQ29udGVudHMgNCAwIFIgPj4KZW",
      "5kb2JqCjQgMCBvYmoKPDwgL0xlbmd0aCAzNyA+PgpzdHJlYW0KQlQKL0YxIDEyIFRmCjcyIDcyMCBUZAooSGVsbG8p",
      "IFRqCkVUCmVuZHN0cmVhbQplbmRvYmoKNSAwIG9iago8PCAvVGl0bGUgKENsYXNzaWMgRml4dHVyZSkgL0F1dGhvci",
      "AocGRmYm94LW5ldCkgPj4KZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxNSAwMDAw",
      "MCBuIAowMDAwMDAwMDY0IDAwMDAwIG4gCjAwMDAwMDAxMjEgMDAwMDAgbiAKMDAwMDAwMDIwOCAwMDAwMCBuIAowMD",
      "AwMDAwMjk0IDAwMDAwIG4gCnRyYWlsZXIKPDwgL1NpemUgNiAvUm9vdCAxIDAgUiAvSW5mbyA1IDAgUiA+PgpzdGFy",
      "dHhyZWYKMzYxCiUlRU9GCg==",
    ].join
    (testpath/"fixture.pdf").binwrite(Base64.decode64(fixture))
    system bin/"unpdf", "fixture.pdf", "--output", "html", "--quiet"
    assert_match "Hello", (testpath/"html/index.html").read
  end
end
