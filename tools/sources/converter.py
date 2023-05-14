def get_colors(fills):
    colors = dict()

    if fills["type"] == "SOLID":
        if "color" in fills:
            colors = fills["color"]
            alpha = fills.get("opacity", 1.0)
            colors["a"] *= alpha
            return convert_to_hex(colors, fills["type"])

    elif fills["type"] == "GRADIENT_ANGULAR":
        if "gradientStops" in fills:
            colors = fills["gradientStops"]
            return convert_to_hex(colors, fills["type"])

    elif fills["type"] == "GRADIENT_LINEAR":
        if "gradientStops" in fills:
            colors = fills["gradientStops"]
            return convert_to_hex(colors, fills["type"])

    return None


# Prevent value overflow
def checked_hex(value):
    if value > 1.0 or value < 0:
        exit("Invalid color value: ", value)
    hex_val = hex(round(value * 255)).split('x')[-1].upper()
    return f"0{hex_val}" if len(hex_val) < 2 else hex_val


# Convert dict of colors to RGBA hex string
def floats_to_hex(colors):
    output = "0x"
    red = colors["r"]
    green = colors["g"]
    blue = colors["b"]
    alpha = colors["a"]

    return output + \
        checked_hex(red) + \
        checked_hex(green) + \
        checked_hex(blue) + \
        checked_hex(alpha)


def convert_to_hex(colors, style: str):
    if style == "SOLID":
        output = dict()
        output["style"] = "SOLID"
        output["colors"] = [{"color": floats_to_hex(colors)}]
        return output

    elif style == "GRADIENT_ANGULAR":
        output = dict()
        color_items = []
        for item in colors:
            item["color"] = floats_to_hex(item["color"])
            item["position"] = round(item["position"], 3)
            color_items.append(item)
        output["style"] = "GRADIENT_ANGULAR"
        output["colors"] = color_items
        return output

    elif style == "GRADIENT_LINEAR":
        output = dict()
        color_items = []
        for item in colors:
            item["color"] = floats_to_hex(item["color"])
            item["position"] = round(item["position"], 3)
            color_items.append(item)
        output["style"] = "GRADIENT_LINEAR"
        output["colors"] = color_items
        return output
