{
  outputs =
    { ... }:
    {
      overlays.default = final: prev: {
        python312Packages = prev.python312Packages.override {
          overrides = _: pyprev: {
            tensorflow-bin = pyprev.tensorflow-bin.overridePythonAttrs (_: {
              pname = "tensorflow";
              version = "2.19.0";
              src = prev.fetchurl {
                url = "https://github.com/mkorje/frigate/releases/download/v2.19.0-312/tensorflow_cpu-2.19.0-cp312-cp312-linux_x86_64.whl";
                sha256 = "12qz7lwf2knhxxn6yw3xvljahn8gz0zfl2kil9hkxm6mzp22xx40";
              };
            });
          };
        };
        frigate = prev.frigate.override {
          inherit (final) python312Packages;
        };
        nginxStable = prev.nginxStable.overrideAttrs (oldAttrs: {
          env.NIX_CFLAGS_COMPILE =
            (oldAttrs.env.NIX_CFLAGS_COMPILE or "") + " -Wno-error=deprecated-declarations";
        });
      };
    };
}
