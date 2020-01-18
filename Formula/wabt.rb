class Wabt < Formula
  desc "Web Assembly Binary Toolkit"
  homepage "https://github.com/WebAssembly/wabt"
  url "https://github.com/WebAssembly/wabt.git",
    :tag      => "1.0.13",
    :revision => "7c80d05e37dc02870c680869ae3f04ac6d9637ee"

  bottle do
    cellar :any_skip_relocation
    sha256 "baeaed567994766f860377137d7d9775ad416e4bd4eb179abd7db98aec01fb75" => :catalina
    sha256 "b60e1c032adcf32bfda6358f666dfcba39d7e113a9546876b52c0082541e1263" => :mojave
    sha256 "dc94e7b9d892b2edfa2c4dec4e11d4b42ec20ae1f1cb93b242bab073ec1bbf70" => :high_sierra
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-DBUILD_TESTS=OFF", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"sample.wast").write("(module (memory 1) (func))")
    system "#{bin}/wat2wasm", testpath/"sample.wast"
  end
end
