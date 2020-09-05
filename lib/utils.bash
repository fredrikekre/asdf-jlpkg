#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/fredrikekre/jlpkg"

fail() {
  echo -e "asdf-jlpkg: $*"
  exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

download_release() {
  local install_type="$1"
  local version="$2"
  local download_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-jlpkg supports release installs only"
  fi

  local url="$GH_REPO/releases/download/v$version/jlpkg-v$version.tar.gz"
  (
    echo "asdf-jlpkg: downloading jlpkg release $version."
    rm -rf "$download_path"
    mkdir -p "$download_path"
    curl "${curl_opts[@]}" -C - "$url" | tar -xz -C "$download_path" || fail "Could not download $url"
  ) || (
    rm -rf "$download_path"
    fail "An error occured while downloading jlpkg $version"
  )
}

install_version() {
  local version="$1"
  local install_path="$2"
  local download_path="$3"

  # TODO: Check that julia is installed ??
  (
    rm -rf "$install_path"
    mkdir -p "$install_path/bin"
    cp "$download_path/jlpkg" "$install_path/bin/"

    test -x "$install_path/bin/jlpkg" || fail "Expected $install_path/bin/jlpkg to be executable."

    echo "asdf-jlpkg: jlpkg $version installation was successful."
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing jlpkg $version."
  )
}
