#!/bin/bash

# Direktori target
TARGET_DIR="/root/enc/menu"

# Periksa apakah direktori ada
if [ ! -d "$TARGET_DIR" ]; then
  echo "Direktori $TARGET_DIR tidak ditemukan!"
  exit 1
fi

# Iterasi setiap file di direktori
for file in "$TARGET_DIR"/*; do
  # Abaikan jika bukan file
  if [ ! -f "$file" ]; then
    continue
  fi

  # Nama file tanpa direktori
  filename=$(basename -- "$file")

  # Periksa apakah file berakhiran .sh
  if [[ "$filename" == *.sh ]]; then
    # Hapus akhiran .sh
    new_name="${filename%.sh}"
  else
    # Tambahkan akhiran .sh
    new_name="${filename}.sh"
  fi

  # Ubah nama file
  mv "$file" "$TARGET_DIR/$new_name"
  echo "Renamed: $filename -> $new_name"
done

echo "Proses selesai."

