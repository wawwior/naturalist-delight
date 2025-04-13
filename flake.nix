{
  inputs = {
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    inputs.utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        jdk-17 = pkgs.temurin-bin-17;
        jdk-21 = pkgs.temurin-bin-21;
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            gradle
            jdt-language-server
          ];

          JAVA_HOME = "${jdk-21.home}";

          JDK_17 = "${jdk-17.home}";
          JDK_21 = "${jdk-21.home}";
        };
      }
    );
}
