#!/bin/bash

target_dir="$HOME/Downloads/flatpak"

if [ ! -d "$target_dir" ]; then

	mkdir -p "$target_dir"
fi

cd $target_dir

lftp -e "mirror -c; exit" http://10.98.20.1/flatpak/

while [ "$(find . -mindepth 1 -maxdepth 1 -type f -name "*.flatpak" -print -quit 2>/dev/null)" ]; do

	find . -mindepth 1 -maxdepth 1 -type f -name "*.flatpak" | while read p; do

		flatpak install -y "$p" && rm -f "$p"
	done
done
