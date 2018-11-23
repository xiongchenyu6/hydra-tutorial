# nixpkgs-ci.nix

{ supportedSystems ? ["i686-linux" "x86_64-linux"] }:

with (import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; });

{

  # 'hydraJob' strips all non-essential attributes.
  hello_world_2 = pkgs.lib.hydraJob pkgs.x86_64_linux.hello;

  # Generate one attribute per supported platform.
  hello_world_3 = pkgs.lib.genAttrs supportedSystems (system: (pkgsFor system).hello);

} // mapTestOn {

  # Fancy shortcut to generate one attribute per supported platform.
  hello = supportedSystems;

}
