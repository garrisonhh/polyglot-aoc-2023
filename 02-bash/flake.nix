{
  inputs.nixpkgs.url = github:NixOs/nixpkgs/nixos-23.11;

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = (import nixpkgs){
        inherit system;
      };

      devShell = pkgs.mkShell {};
    in
    {
      devShells.${system}.default = devShell;
    };
}
