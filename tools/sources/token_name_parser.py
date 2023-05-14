# Convert token name "Group Name/Style Name/theme" -> "GroupName.styleName:theme"
# Change this method if the naming of your tokens is different
def convert_token_name(name: str, style):
    parts = name.replace("-", "_").split("/")

    group_parts = parts[0].split(" ")
    group_name = "".join(group_parts)
    group_name = group_name[0].upper() + group_name[1:]

    token_parts = parts[1].split(" ")
    token_name = "".join(token_parts)
    if style == "SOLID":
        token_name = token_name[0].lower() + token_name[1:]

    if len(parts) == 3 and group_parts[2] == "dark":
        theme = "dark"
    else:
        theme = "light"

    new_name = f"{group_name}.{token_name}:{theme}"
    return new_name
