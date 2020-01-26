# Timelog

## Usage

### From a `sh`/`bash` or similar terminal

Save a script (e.g., titled `timelog.R`), with the following contents:

```
#!Rscript
args <- commandArgs(trailingOnly=TRUE)

if (length(args) == 0) {
  stop("At least one argument must be supplied (input file)", call. = FALSE)
}

input <- yaml::read_yaml(args[1])
timelog::parse_times(
  input,
  returnIntermediateTable = ifelse(
    is.na(args[2]),
    FALSE,
    as.logical(args[2])
  )
)

```

You can then call the script from a Bash Terminal with `Rscript timelog.R path/to/log-file.yaml`

### Text Editor Snippets

An example VSCode snippet:

```
"day-times": {
  "prefix": "day-times",
  "body": "${1:Monday 01-01}:\n  targetDuration: ${2:true}\n  times:\n    - ${3:+00M}"
}
```

## Building and testing

For information on R packaging, see http://r-pkgs.had.co.nz/.

Keyboard shortcuts for package authoring within RStudio:

- Build and Reload Package: `Cmd + Shift + B`
- Check Package: `Cmd + Shift + E`
- Test Package: `Cmd + Shift + T`
