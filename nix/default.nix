{ sources ? import ./sources.nix
, system ? null
}:
let
  
  pythonOverlay = (self: super:
    let
      extraLibs = {
        packageOverrides = self: super: rec {
          localstack-client = super.buildPythonPackage rec {
            pname = "localstack-client";
            version = "0.24";
            doCheck = false;
            propagatedBuildInputs = [ 
              pkgs.python38Packages.boto3 
            ];
            src = super.fetchPypi {
              inherit pname version;
              sha256 = "m+Pr5+xx3oTVRKV+gebAMkruoBADKL32Ukg1w/ToeAs=";
            };
          };
          localstack-ext = super.buildPythonPackage rec {
            pname = "localstack-ext";
            version = "0.11.28";
            doCheck = false;
            propagatedBuildInputs = [ 
              pkgs.python38Packages.requests
              pkgs.python38Packages.dnspython
              pkgs.python38Packages.pyaes
              pkgs.python38Packages.dnslib
            ];
            src = super.fetchPypi {
              inherit pname version;
              sha256 = "m2AL3wFEgT+BxAmCEOS+CM3kPi6BmAkvZ5P4qhdFkes=";
            };
          };
          localstack = super.buildPythonPackage rec {
            pname = "localstack";
            version = "0.11.3";
            doCheck = false;
            propagatedBuildInputs = [ 
              localstack-client 
              localstack-ext
              pkgs.python38Packages.docopt
              pkgs.python38Packages.requests
              pkgs.python38Packages.dnspython
            ];
            src = super.fetchPypi {
              inherit pname version;
              sha256 = "Zo7wbimlUxLL8ZwQqDlJUe1L41EH+4jVyOAOItHG1JU=";
            };
          };
        };
      };
    in {
      python38 = super.python38.override extraLibs;
    }
  );

  passthrough = self: super: rec {
    rootFolder = toString ../.;
  };

  overlays = [
    passthrough
    pythonOverlay
  ];

  args = { inherit overlays; } // {
    inherit overlays;
  } // (if system != null then { inherit system; } else { });

  pkgs = import sources.nixpkgs args;
in pkgs
