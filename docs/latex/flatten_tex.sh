#!/bin/bash

INPUT_FILE="$1"
OUTPUT_FILE="$2"

flatten() {
  local file="$1"
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" =~ \\(input|include)\{([^}]+)\} ]]; then
      local cmd="${BASH_REMATCH[1]}"
      local included_file="${BASH_REMATCH[2]}"
      if [[ "$included_file" != *.tex ]]; then
        included_file="${included_file}.tex"
      fi
      if [[ -f "$included_file" ]]; then
        flatten "$included_file"
      else
        echo "%% WARNING: File '$included_file' not found" >&2
      fi
    else
      echo "$line"
    fi
  done < "$file"
}

flatten "$INPUT_FILE" > "$OUTPUT_FILE"