import json
import os.path

JSON_FILE_NAME = "../../Output/figma.json"

CYAN = '\033[96m'
GREEN = '\033[92m'
WARN = '\033[93m'
FAIL = '\033[91m'
END = '\033[0m'


def write_json_to_file(data):
    with open(JSON_FILE_NAME, 'w') as f:
        json.dump(data, f, indent=4, sort_keys=True)


def read_json_from_file():
    if not os.path.exists(JSON_FILE_NAME):
        file = open(JSON_FILE_NAME, 'w')
        file.close()
        return dict()
    else:
        with open(JSON_FILE_NAME) as file:
            data = json.load(file)

    return data


# Check previous version of JSON file for added, renamed and deleted tokens
# using 'key' comparing (assuming it never changes)
def check_json_for_updates(palette):
    output: [str] = []
    json_file = read_json_from_file()
    new_names = dict()
    names = dict()

    for group, group_value in json_file.items():
        for token, token_value in group_value.items():
            names[token_value["key"]] = f"{group}.{token}"

    for new_group, new_group_value in palette.items():
        for new_token, new_token_value in new_group_value.items():
            new_names[new_token_value["key"]] = f"{new_group}.{new_token}"

    # Print token with new 'key'
    for item in (new_names.keys() - names.keys()):
        output.append(CYAN + f"Added: {new_names[item]}" + END)

    # Print old and new names of token with same 'key'
    for key in names.keys():
        if key in new_names:
            if names[key] != new_names[key]:
                output.append(WARN + f"Renamed: {names[key]} -> {new_names[key]}" + END)

    # Print token with now absent 'key'
    for item in (names.keys() - new_names.keys()):
        output.append(FAIL + f"Deleted: {names[item]}" + END)

    return output
