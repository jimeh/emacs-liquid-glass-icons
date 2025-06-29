# EmacsLG Legacy *.icns Exports

We have a `EmacsLG-Iconsets.afdesign` Affinity Designer document which contains
high-res versions of all icon variants, and export configurations to export all
icons at all required sizes to relevant `*.iconset` folders.

I picked Affinity Designer cause I'm familiar with its export features.

## Exporting *.iconset directories

Within Affinity Designer, simply switch to the Export persona, and click the
"Export Slices" button. This will create all `*.iconset` directories with all
resolutions of images.

## Create *.icns files

The `*.icns` icon files are creates from the `*.iconset` directories using the
`iconutil` CLI tool:

```bash
iconutil -c icns 'EmacsLG1-Default.iconset'
iconutil -c icns 'EmacsLG1-Dark.iconset'
iconutil -c icns 'EmacsLG2-Default.iconset'
iconutil -c icns 'EmacsLG2-Dark.iconset'
iconutil -c icns 'EmacsLG3-Default.iconset'
iconutil -c icns 'EmacsLG3-Dark.iconset'
```
