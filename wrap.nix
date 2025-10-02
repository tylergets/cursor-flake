cursorDrv: {
  pkgs,
  lib,
  ...
}: let
  cursor = cursorDrv.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [pkgs.wrapGAppsHook];
  });
in
  cursor
  // {
    inherit lib;
  }
