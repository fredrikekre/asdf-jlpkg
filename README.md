# asdf-jlpkg

| **Build Status**             |
|:---------------------------- |
| ![][build-img] ![][lint-img] |

[`jlpkg`](https://github.com/fredrikekre/jlpkg) plugin for the [`asdf` version manager](https://asdf-vm.com).

## Install

1. Make sure Julia is installed and available in `PATH`. This can e.g. be done by using the
   [`asdf-julia`](https://github.com/rkyleg/asdf-julia) plugin.

2. Install the `asdf-jlpkg` plugin:

   ```shell
   asdf plugin add jlpkg https://github.com/fredrikekre/asdf-jlpkg.git
   ```

3. Install `jlpkg`:

   ```shell
   # Show all installable versions
   asdf list-all jlpkg

   # Install specific version
   asdf install jlpkg latest

   # Set a version globally (in your ~/.tool-versions file)
   asdf global jlpkg latest

   # Now jlpkg commands are available
   jlpkg --version
   ```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.


[build-img]: https://github.com/fredrikekre/asdf-jlpkg/workflows/Build/badge.svg
[lint-img]: https://github.com/fredrikekre/asdf-jlpkg/workflows/Lint/badge.svg
