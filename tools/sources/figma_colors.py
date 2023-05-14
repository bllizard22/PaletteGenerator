import warnings

import converter
import token_name_parser
import figma_api


# Filter color (style_type=FILL) from typography
# and skip all unused properties to get {"GroupName.tokenName:theme": colors: {}}
def get_style_values():
    styles = figma_api.get_styles()
    nodes_ids: [str] = []
    keys = dict()
    for style in styles:
        if style["style_type"] == "FILL":
            nodes_ids.append(style["node_id"])
            keys[style["node_id"]] = style["key"]

    node_id = ",".join(nodes_ids)

    nodes = dict(figma_api.get_nodes(node_id)["nodes"])

    output = dict()
    for value in nodes.values():
        raw_name = value["document"]["name"]
        name = token_name_parser.convert_token_name(raw_name, value["document"]["fills"][0]["type"])
        fills = value["document"]["fills"][0]
        colors = converter.get_colors(fills)
        style_id = value["document"]["id"]
        colors["key"] = keys[style_id]
        if colors:
            output[name] = colors

    return output


# Search for pairs of {"GroupName.tokenName:theme": colors: {}} with theme as light and dark
# to combine them as {"GroupName.tokenName": {dark: colors, light: colors}}
def combine_with_theme(palette: dict):
    output = dict()

    for key, value in palette.items():
        key_parts = key.split(":")
        new_key = key_parts[0]
        theme = key_parts[1]

        if new_key in output:
            new_dict = output[new_key]
            new_dict[theme] = value
            output[new_key] = new_dict
        else:
            new_dict = dict()
            new_dict[theme] = value
            output[new_key] = new_dict

        output[new_key]["style"] = value.pop("style", None)
        output[new_key]["key"] = value.pop("key", None)

    return output


# Invert nesting from {dark: colors: {[...]}, light: colors: {[...]}}
# to {colors: [{dark: HEX_RGBA, light: HEX_RGBA}, ...]}
def recombine_to_colors_with_theme(palette: dict):
    output = dict()

    for key, value in palette.items():
        output[key] = dict()
        output[key]["colors"] = []
        style = value["style"]
        if style == "GRADIENT_ANGULAR" or style == "GRADIENT_LINEAR":
            output[key]["positions"] = []
        output[key]["style"] = value.pop("style", None)
        output[key]["key"] = value.pop("key", None)

        if "light" not in value:
            value["light"] = {"colors": [{"color": "null", "position": "null"}]}
            warnings.warn(
                f"Error with generating {style} {key} {value} [light]\n"
                f"Search for 'null' in JSON file"
            )
        if "dark" not in value:
            value["dark"] = {"colors": [{"color": "null", "position": "null"}]}
            warnings.warn(
                f"Error with generating {style} {key} {value} [dark]\n"
                f"Search for 'null' in JSON file"
            )
        for light, dark in zip(value["light"]["colors"], value["dark"]["colors"]):
            output[key]["colors"].append({"light": light["color"], "dark": dark["color"]})
            if style == "GRADIENT_ANGULAR" or style == "GRADIENT_LINEAR":
                output[key]["positions"].append(str(light["position"]))

    return output


# Add nesting level by splitting {"GroupName.tokenName": {...}}
# to {GroupName: [tokenName: {...}, ...]}
def combine_with_groups(palette: dict):
    output = dict()

    for raw_key, value in palette.items():
        group, style = raw_key.split(".")

        if group in output:
            output[group][style] = value
        else:
            output[group] = {style: value}

    return output
