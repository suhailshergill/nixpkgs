{ cabal, cereal, cryptoApi, filepath, hspec, tagged }:

cabal.mkDerivation (self: {
  pname = "skein";
  version = "1.0.3";
  sha256 = "15vzydywhwjdgybabvv6lfk1vjs7blvs3k2apwxjdjh2q7jmgkam";
  buildDepends = [ cereal cryptoApi tagged ];
  testDepends = [ cereal cryptoApi filepath hspec tagged ];
  meta = {
    homepage = "https://github.com/meteficha/skein";
    description = "Skein, a family of cryptographic hash functions. Includes Skein-MAC as well.";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
