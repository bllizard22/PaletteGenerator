# PaletteGenerator
This tool helps:
- Use Figma API to fetch [colors data](#Figma-API-fetcher)
  > Styles library should be published to enable API usage
- Rearrange it in case you have light/dark mode values
- [Generate](#Swift-CodeGen) swift file from fetched data
- Print out added, deleted, and renamed tokens using `key` parameter to compare
  
  <img width="600" alt="image" src="https://github.com/bllizard22/PaletteGenerator/assets/37974438/f25a8dcf-b309-4e6a-b6bb-83e21caa1d9a">


## Quick Start

- Start with adding all required [values](tools/README.md)
- Compile script with `./buildGenerator.sh`
- Execute `./PaletteGenerator`

## Figma API fetcher

Uses public Figma API to collect data from the styles library and prepare reusable JSON.
[Details here](tools/README.md)

<img width="600" alt="image" src="https://github.com/bllizard22/PaletteGenerator/assets/37974438/d60fb6a3-536f-4fcc-a7fd-e5085c752aac">


## Swift CodeGen
This stage generates Swift file with color values enum using Stencil.
It takes data from **Figma API fetcher** output JSON.

You can check templates for generator [here](Project/Sources/PaletteGenerator/Stencils)

<img width="600" alt="image" src="https://github.com/bllizard22/PaletteGenerator/assets/37974438/a162a5ac-76e8-4cb7-b1a7-8dcbec2a9f42">

