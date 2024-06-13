# only works with python3Packages.tree-sitter < 0.22.0

{ buildPythonPackage
, cython
, fetchFromGitHub
, lib
, pkgs
, pytestCheckHook
, tree-sitter
, ...
}:
let
  version = "1.10.2";
  allGrammars = pkgs.tree-sitter.withPlugins (p: lib.attrValues p);
in
buildPythonPackage {
  pname = "tree-sitter-languages";
  inherit version;

  src = fetchFromGitHub {
    owner = "grantjenks";
    repo = "py-tree-sitter-languages";
    rev = "v${version}";
    hash = "sha256-AuPK15xtLiQx6N2OATVJFecsL8k3pOagrWu1GascbwM=";
  };

  postPatch = ''
    substituteInPlace tree_sitter_languages/core.pyx --replace \
      "binary_path = str(pathlib.Path(__file__).parent / filename)" \
      "binary_path = str(pathlib.Path(\"${allGrammars}\") / (language + \".so\"))"

    # Disable tests for languages for which there is no grammar in nixpkgs.
    substituteInPlace tests/test_tree_sitter_languages.py --replace "'fixed_form_fortran'," ""
    substituteInPlace tests/test_tree_sitter_languages.py --replace "'hack'," ""
    substituteInPlace tests/test_tree_sitter_languages.py --replace "'objc'," ""
    substituteInPlace tests/test_tree_sitter_languages.py --replace "'perl'," ""
    substituteInPlace tests/test_tree_sitter_languages.py --replace "'sqlite'," ""
  '';

  nativeBuildInputs = [ cython ];

  propagatedBuildInputs = [ tree-sitter ];

  # make relative imports work in tests
  # https://github.com/grantjenks/py-tree-sitter-languages/blob/42f4baffec92848be4937b0cc52b2872201fe322/tree_sitter_languages/__init__.py#L4
  preCheck = ''
    rm -r tree_sitter_languages
  '';

  nativeCheckInputs = [ pytestCheckHook ];
}
