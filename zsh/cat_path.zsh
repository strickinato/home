# Pretty print $PATH variable
cat_path() {
  tr ':' '\n' <<< "$PATH"
}
