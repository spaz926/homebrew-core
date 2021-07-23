class VulkanHeaders < Formula
  desc "Vulkan Header files and API registry"
  homepage "https://github.com/KhronosGroup/Vulkan-Headers"
  url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.2.185.tar.gz"
  sha256 "d526d9454cf82accc1bac1e3744b0b4daff5ec0203868d070c6f22a7d12919ee"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "c895f0041aae866e240d1558316e20f8e6a473bb7c115609b45f4d8309574034"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <vulkan/vulkan_core.h>

      int main() {
        printf("vulkan version %d", VK_VERSION_1_0);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test"
    system "./test"
  end
end
