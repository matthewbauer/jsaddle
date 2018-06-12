{ mkDerivation, stdenv, aeson, base, bytestring, jsaddle, data-default
, buildPackages, hostPlatform
}:

mkDerivation {
  pname = "jsaddle-wkwebview";
  version = "0.9.4.0";
  src = ./.;
  libraryHaskellDepends = [ aeson base bytestring jsaddle data-default ];
  libraryFrameworkDepends = with buildPackages; if hostPlatform.useiOSCross or false then [
    "${darwin.xcode_8_2}/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System"
  ] else [
    darwin.libobjc
    darwin.apple_sdk.libs.xpc
    darwin.apple_sdk.frameworks.Foundation
    darwin.apple_sdk.frameworks.Cocoa
    darwin.apple_sdk.frameworks.WebKit
  ];
  description = "Interface for JavaScript that works with GHCJS and GHC";
  license = stdenv.lib.licenses.mit;
}
