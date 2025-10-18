<div align="center">

<img width="512px" src="https://raw.githubusercontent.com/jimeh/emacs-liquid-glass-icons/refs/heads/main/img/logo.png" alt="Logo">

# Emacs Liquid Glass Icons

**Emacs app icons in macOS 26's new Liquid Glass style.**

[![Latest Release](https://img.shields.io/github/release/jimeh/emacs-liquid-glass-icons.svg)](https://github.com/jimeh/emacs-liquid-glass-icons/releases)
[![GitHub Issues](https://img.shields.io/github/issues/jimeh/emacs-liquid-glass-icons.svg)](https://github.com/jimeh/emacs-liquid-glass-icons/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/jimeh/emacs-liquid-glass-icons.svg)](https://github.com/jimeh/emacs-liquid-glass-icons/pulls)
[![License](https://img.shields.io/github/license/jimeh/emacs-liquid-glass-icons.svg)](https://github.com/jimeh/emacs-liquid-glass-icons/blob/main/LICENSE)

</div>

## Overview

Created with Apple's new [Icon Composer][] application, using SVG shapes
extracted from [emacs.svg][] image included in Emacs' sources.

[Icon Composer]: https://developer.apple.com/icon-composer/
[emacs.svg]: https://github.com/emacs-mirror/emacs/blob/emacs-30.1/etc/images/icons/hicolor/scalable/apps/emacs.svg

A series of `*.icns` files are provided for macOS 15 and earlier, and a
`Assets.car` file is provided for macOS 26 and later.

## Usage

### macOS 15 and earlier

Grab the `.icns` file you prefer from the `Resources` directory, and replace
`Contents/Resources/Emacs.icns` within your Emacs.app.

It may take a while for macOS to realize the change, you can try and speed it by
temporarily renaming the Emacs app to something else and then back again.

### macOS 26

On macOS 26, the icons support light/dark mode, clear glass mode, and custom
color tints as well. However, this works a bit different from the old `.icns`
files on earlier macOS versions.

Grab the `Assets.car` file from the `Resources` directory, and place it into
`Contents/Resources` within your Emacs.app.

Then edit `Contents/Info.plist`, and add/update the following:

```xml
<key>CFBundleIconName</key>
<string>EmacsLG1</string>
```

Set the value to one of `EmacsLG1`, `EmacsLG2`, or `EmacsLG3` depending on which
icon you want to use. All three are bundled into the `Assets.car` file.

The existing `Contents/Resources/Emacs.icns` file with Emacs' default icon can
be left alone. Or you can replace it with one of the `EmacsLG*.icns` files from
the `Resources` directory to change the icon for pre-Tahoe macOS versions as
well.

## The Icons

### EmacsLG1

EmacsLG1 simplifies and changes the outer shape of the default icon to comply
with the shape of Liquid Glass icons.

![EmacsLG1 Preview](https://raw.githubusercontent.com/jimeh/emacs-liquid-glass-icons/refs/heads/main/img/EmacsLG1-preview.png)

### EmacsLG2

EmacsLG2 stays as close to the original round icon as possible, while giving it
that Liquid Glass flair.

![EmacsLG2 Preview](https://raw.githubusercontent.com/jimeh/emacs-liquid-glass-icons/refs/heads/main/img/EmacsLG2-preview.png)

### EmacsLG3

EmacsLG3 is the biggest divergence from Emacs' default icon, and is inspired by
the changes Apple has made to some of its own icons in macOS 26.

![EmacsLG3 Preview](https://raw.githubusercontent.com/jimeh/emacs-liquid-glass-icons/refs/heads/main/img/EmacsLG3-preview.png)

## License

Licensed under GPL-3.0-or-later (see `LICENSE.md`).

These icons are derivative works of [emacs.svg][], which is [licensed under
GPL-3.0-or-later][upstream-license].

[upstream-license]: https://github.com/emacs-mirror/emacs/blob/emacs-30.1/etc/images/icons/README
