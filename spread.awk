# spread.awk -- Charlotte Koch <dressupgeekout@gmail.com>

BEGIN {
  # Fields are separated by 1 or more tabs.
  FS = "\t+"

  # Each record is on its own line. (Also the default.)
  RS = "\n"

  # These are actually the default output field and record separators.
  OFS = " "
  ORS = "\n"
}

# Ignore blank lines and hash-style comments.
/^[[:blank:]]*$/ || /^#/ { next }
