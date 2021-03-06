{ fetchurl, stdenv, cairo, freetype, fontconfig, zlib
, libjpeg, pixman, curl, libpthreadstubs, libXau, libXdmcp, openjpeg
, libxml2, pkgconfig, cmake, lcms
, gtkSupport ? false, glib ? null, gtk ? null
, qt4Support ? false, qt4 ? null
}:

stdenv.mkDerivation rec {
  name = "poppler-0.22.4";

  src = fetchurl {
    url = "${meta.homepage}${name}.tar.gz";
    sha256 = "0fz1vk0rbxvnv7ssj8l910k1rx0gjhzl5wr7hkdf4r9jwqs8yhsg";
  };

  propagatedBuildInputs =
    [ zlib cairo freetype fontconfig libjpeg lcms pixman curl
      libpthreadstubs libXau libXdmcp openjpeg libxml2 stdenv.gcc.libc
    ]
    ++ stdenv.lib.optionals gtkSupport [ glib gtk ]
    ++ stdenv.lib.optional qt4Support qt4;

  nativeBuildInputs = [ pkgconfig cmake ];

  cmakeFlags = "-DENABLE_XPDF_HEADERS=ON -DENABLE_LIBCURL=ON -DENABLE_ZLIB=ON";

  patches = [ ./datadir_env.patch ];

  # XXX: The Poppler/Qt4 test suite refers to non-existent PDF files
  # such as `../../../test/unittestcases/UseNone.pdf'.
  #doCheck = !qt4Support;
  checkTarget = "test";

  enableParallelBuilding = true;

  meta = {
    homepage = http://poppler.freedesktop.org/;
    description = "Poppler, a PDF rendering library";

    longDescription = ''
      Poppler is a PDF rendering library based on the xpdf-3.0 code base.
    '';

    platforms = if qt4Support
      then qt4.meta.platforms
      else stdenv.lib.platforms.all;

    license = "GPLv2";
  };
}
