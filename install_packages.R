
PACKAGES <- c(
    "tidyverse", "wooldridge", "sf", "tigris", "future", "furrr",
    "parallelly", "this.path", "mice", "VIM", "patchwork", "ggmice",
    "lmtest", "sandwich", "broom", "ggspatial", "kableExtra",
    "xtable", "ggdist", "biscale", "scales", "cowplot", "knitr"
)

find_missing <- function(pkg_list) {
    pkg_list[!sapply(pkg_list, requireNamespace, quietly = TRUE)]
}

report_status <- function(pkg_list) {
    cat("Checking installed R packages...\n")
    status <- sapply(pkg_list, requireNamespace, quietly = TRUE)
    for (pkg in pkg_list) {
        if (status[[pkg]]) {
            cat(sprintf("  %s is already installed\n", pkg))
        } else {
            cat(sprintf("  %s - MISSING\n", pkg))
        }
    }
    invisible(status)
}
install_and_verify <- function(pkg_list) {
    report_status(pkg_list)
    missing_pkgs <- find_missing(pkg_list)
    if (length(missing_pkgs) == 0) {
        cat("\nNo missing packages xD\n")
        return(invisible(NULL))
    }
    cat(sprintf("\nFound %d missing package(s). Installing...\n", length(missing_pkgs)))
    for (pkg in missing_pkgs) {
        tryCatch(
            {
                install.packages(pkg, quiet = TRUE)
                cat(sprintf("  Successfully installed: %s\n", pkg))
            },
            error = function(e) {
                cat(sprintf("  Failed to install: %s (%s)\n", pkg, conditionMessage(e)))
            }
        )
    }
    cat("\nVerifying installation...\n")
    still_missing <- find_missing(pkg_list)
    if (length(still_missing) > 0) {
        cat("\nThe following packages failed to install or load:\n")
        cat(paste0("  - ", still_missing, collapse = "\n"), "\n")
    } else {
        cat("\nAll packages are now properly installed and ready to use!\n")
    }
    invisible(NULL)
}

install_and_verify(PACKAGES)