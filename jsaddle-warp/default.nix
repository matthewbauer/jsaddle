{ mkDerivation, aeson, base, bytestring, containers, deepseq
, doctest, filepath, foreign-store, ghc-prim, http-types, jsaddle
, lens, network, primitive, process, QuickCheck, ref-tf, stdenv
, stm, text, time, transformers, uuid, uuid-types, wai
, wai-websockets, warp, webdriver, websockets, ghc
}:
mkDerivation {
  pname = "jsaddle-warp";
  version = "0.9.6.0";
  src = builtins.filterSource (path: type: !(builtins.elem (baseNameOf path) [ ".git" "dist" ])) ./.;
  libraryHaskellDepends = [
    base
  ] ++ (if ghc.isGhcjs or false
    then []
    else [
    aeson bytestring containers foreign-store http-types jsaddle
    stm text time transformers uuid uuid-types wai wai-websockets warp
    websockets
  ]);
  testHaskellDepends = if ghc.isGhcjs or false
    then []
    else [
    aeson base bytestring containers deepseq doctest filepath ghc-prim
    http-types jsaddle lens network primitive process QuickCheck ref-tf
    stm text time transformers wai wai-websockets warp webdriver
    websockets
  ];
  testTarget = "--test-option=${jsaddle.src}";
  description = "Interface for JavaScript that works with GHCJS and GHC";
  license = stdenv.lib.licenses.mit;
}
