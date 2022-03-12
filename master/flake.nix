{
  description = ''Wrapper-less C/C++ interop for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimline-master.flake = false;
  inputs.src-nimline-master.owner = "fragcolor-xyz";
  inputs.src-nimline-master.ref   = "refs/heads/master";
  inputs.src-nimline-master.repo  = "nimline";
  inputs.src-nimline-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimline-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimline-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}