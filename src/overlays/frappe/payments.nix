{
  appSources,
  lib,
  buildPythonPackage,
  flit-core,
  pythonRelaxDepsHook,
  python,
  extractFrappeMeta,
}:
buildPythonPackage rec {
  inherit
    (extractFrappeMeta src)
    pname
    version
    format
    ;

  inherit (appSources.payments) src passthru;

  nativeBuildInputs = [
    pythonRelaxDepsHook
    flit-core
  ];

  propagatedBuildInputs = with python.pkgs; [
    braintree
    paytmchecksum
    pycryptodome
    razorpay
    stripe
  ];

  pythonRelaxDeps = [
    "braintree"
    "pycryptodome"
    "stripe"
    "razorpay"
    "paytmchecksum"
  ];

  # would require frappe, but since frappe is almost certainly customized,
  # we don't include it here / TODO: decide if we may actually add it?
  # pythonImportsCheck = ["payments"];

  meta = with lib; {
    description = "Payments app for frappe";
    homepage = "https://github.com/frappe/payments.git";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
