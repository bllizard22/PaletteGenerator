import requests
import warnings

import converter

# Example made with copy of Uber Base Design System
# https://www.figma.com/file/hYiSlGpd2dHIQjfWqSgfDA/
FIGMA_FILE_NAME = "hYiSlGpd2dHIQjfWqSgfDA"
# https://www.figma.com/developers/api#access-tokens -> '+ Get personal access token'
FIGMA_TOKEN = {"X-Figma-Token": ""} # <--- insert your token here


# Get list of all styles with node_ids
def get_styles():
    url = f"https://api.figma.com/v1/files/{FIGMA_FILE_NAME}/styles"

    headers = FIGMA_TOKEN

    r = requests.get(url=url, headers=headers)

    if r.status_code == 200:
        data = r.json()["meta"]["styles"]
        return data
    else:
        warnings.warn(f"Figma API request failed with code: {r.status_code} - {r.json()['err']}")
        exit(-1)


# Get all style nodes by node_ids
def get_nodes(by_id: str):
    url = f"https://api.figma.com/v1/files/{FIGMA_FILE_NAME}/nodes"

    headers = FIGMA_TOKEN

    frame_id = by_id
    params = {"ids": frame_id}

    r = requests.get(url=url, headers=headers, params=params)

    if r.status_code == 200:
        return r.json()
    else:
        warnings.warn(f"Figma API request failed with code: {r.status_code} - {r.json()['err']}")
        exit(-1)
