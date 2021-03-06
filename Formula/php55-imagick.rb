require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Imagick < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://github.com/mkoppanen/imagick/archive/3.4.3.tar.gz"
  sha256 "15be7add24705e2541a07425a0806c1f32364399408f757964b5ddf0a0e9cc2d"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "f7bceca3d3bdb3027e3f7480fee74e94d83fe04e7745fb30098e2bedd6604bc3" => :sierra
    sha256 "c7eb975e34a1227d432b74ee7a7a834038e3839d4ec5785dd2c6d82675e082cf" => :el_capitan
    sha256 "5346733eb1342d1c2534bc93347451ac6552dfdf38c667ebbdf87e6cdad2e868" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
