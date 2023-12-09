# Figma API fetcher

## Values
- `io_helpers.JSON_FILE_NAME` - name of output JSON file
- `figma_api.FIGMA_FILE_NAME` - Figma file name. Can be obtained from https://www.figma.com/file/<FIGMA_FILE_NAME>/
- `figma_api.FIGMA_TOKEN` - Figma API token. Can be obtained from https://www.figma.com/developers/api#access-tokens -> *+ Get personal access token*

> Color token name structure is described [here](sources/token_name_parser.py) and can be updated for your needs

## Quick Start

Execute script `colors_generator.py`:
- Get list of styles from your Figma file
- Parse styles and convert them to JSON file using following format:

Solid color:
```
{
    GroupName: {
        tokenName: {
            colors: [
                {
                    dark: HEX_RGBA,
                    light: HEX_RGBA
                }
            ],
            key: 123abc,
            style: SOLID
        }
    }
}
```

Gradient color:
```
{
    GroupName: {
        TokenName: {
            colors: [
                {
                    dark: HEX_RGBA,
                    light: HEX_RGBA
                },
                ...
            ],
            key: 123abc,
            positions: [
                < List with size == len(colors) >
            ]
            style: GRADIENT_LINEAR / GRADIENT_ANGULAR
        }
    }
}
```
