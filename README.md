# PaletteGenerator
This tool helps:
- Use Figma API to fetch [colors data](#Figma-API-fetcher)
  > Styles library should be published to enable API usage
- Rearrange it in case you have light/dark mode values
- [Generate](#Swift-CodeGen) swift file from fetched data
- Print out added, deleted and renamed tokens using 'key' parameter to compare
  
  <img width="600" alt="image" src="https://github.com/bllizard22/PaletteGenerator/assets/37974438/f25a8dcf-b309-4e6a-b6bb-83e21caa1d9a">


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
