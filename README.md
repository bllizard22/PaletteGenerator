# PaletteGenerator
This tool helps:
- Use Figma API to fetch [colors data](#Figma-API-fetcher)
 > Styles library should be published to enable API usage
- Rearrange it in case you have light/dark mode values
- [Generate](#Swift-CodeGen) swift file from fetched data

## Quick Start

- Start with adding all required [values](tools/README.md)
- Compile script with `./buildGenerator.sh`
- Execute `./PaletteGenerator`

## Figma API fetcher

[Details here](tools/README.md)

## Swift CodeGen
This stage generates swift file with colors values enum using Stencil.
It takes data from Figma API fetcher output JSON.

You can check templates for generator [here](Project/Sources/PaletteGenerator/Stencils)