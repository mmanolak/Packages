import subprocess
import sys


PACKAGES = [
    ("pathlib",         "pathlib"),
    ("pandas",          "pandas"),
    ("geopandas",       "geopandas"),
    ("shapely",         "shapely"),
    ("time",            "time"),
    ("osmium",          "osmium"),
    ("multiprocessing", "multiprocessing"),
    ("miceforest",      "miceforest"),
    ("numpy",           "numpy"),
    ("scipy",           "scipy"),
    ("statsmodels",     "statsmodels"),
    ("re",              "re"),
    ("pygris",          "pygris"),
    ("warnings",        "warnings"),
    ("matplotlib",      "matplotlib"),
    ("seaborn",         "seaborn"),
]

def find_missing(pkg_list):
    """
    Check which packages from a list cannot be imported.

    Parameters
    ----------
    pkg_list : list of tuple
        Each tuple is (install_name, import_name).

    Returns
    -------
    list of tuple
        Subset of pkg_list whose import_name cannot be imported.
    """
    missing = []
    for install_name, import_name in pkg_list:
        try:
            __import__(import_name)
        except ImportError:
            missing.append((install_name, import_name))
    return missing


def report_status(pkg_list):
    """
    Print the installation status of every package in pkg_list.

    Parameters
    ----------
    pkg_list : list of tuple
        Each tuple is (install_name, import_name).
    """
    print("Checking installed Python packages...")
    for install_name, import_name in pkg_list:
        try:
            __import__(import_name)
            print(f"  {install_name} is already installed")
        except ImportError:
            print(f"  {install_name} - MISSING")


def install_and_verify(pkg_list):
    """
    Report current status, install any missing packages, then verify.

    Parameters
    ----------
    pkg_list : list of tuple
        Each tuple is (install_name, import_name).
    """
    report_status(pkg_list)

    missing = find_missing(pkg_list)

    if not missing:
        print("\nNo missing packages owo")
        return

    print(f"\nFound {len(missing)} missing package(s). Installing...")

    for install_name, import_name in missing:
        try:
            subprocess.check_call(
                [sys.executable, "-m", "pip", "install", install_name],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            print(f"  Successfully installed: {install_name}")
        except subprocess.CalledProcessError as e:
            print(f"  Failed to install: {install_name} ({e})")

    # Final verification pass after installation attempts
    print("\nVerifying installation...")
    still_missing = find_missing(pkg_list)

    if still_missing:
        names = [n for n, _ in still_missing]
        print(f"\nThe following packages failed to install or load: {names}")
    else:
        print("\nAll packages are now properly installed and ready to use!")

if __name__ == "__main__":
    install_and_verify(PACKAGES)