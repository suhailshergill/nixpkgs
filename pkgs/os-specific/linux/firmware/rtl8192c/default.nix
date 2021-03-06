{stdenv, firmwareLinuxNonfree}:
stdenv.mkDerivation {
  name = "rtl8192c-fw";
  src = firmwareLinuxNonfree;

  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/rtlwifi
    cp "$src/rtlwifi/rtl8192cfw.bin" "$out/rtlwifi/rtl8192cfw.bin"
  '';

  meta = {
    description = "Firmware for the Realtek RTL8192c wireless cards";
    homepage = "http://www.realtek.com";
    license = "non-free";
  };
}
