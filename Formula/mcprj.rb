class Mcprj < Formula
  desc "Read and write Elektron Model:Cycles project files (.mcprj)"
  homepage "https://github.com/am/repreprep/tree/main/tools/mcprj"
  url "https://github.com/am/repreprep/archive/2ab85b4db4e764558d768f4bff04e099b0c46764.tar.gz"
  version "0.1.0"
  sha256 "434b3b0e3330b92d64bc1bf7b08d5e12457cf8ed02c21cc166c78e824cc80565"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["tools/mcprj/*"]
    (bin/"mcprj").write_env_script libexec/"bin/mcprj.mjs", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  test do
    system bin/"mcprj", "new", "TEST", "-o", "test.mcprj"
    assert_match "checksum OK", shell_output("#{bin}/mcprj check test.mcprj")
    system bin/"mcprj", "build", libexec/"examples/night-beat.json", "-o", "night.mcprj"
    assert_match "NIGHT BEAT", shell_output("#{bin}/mcprj info night.mcprj")
  end
end
