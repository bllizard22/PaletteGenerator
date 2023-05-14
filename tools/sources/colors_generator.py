import figma_colors
import io_helpers


if __name__ == '__main__':
    # figma_colors.py
    raw_palette = figma_colors.get_style_values()
    print(f"Get {len(raw_palette)} styles")

    raw_palette = figma_colors.combine_with_theme(raw_palette)
    print(f"{len(raw_palette)} styles combined with theme")

    raw_palette = figma_colors.recombine_to_colors_with_theme(raw_palette)
    print(f"{len(raw_palette)} styles recombined with color:theme")

    palette = figma_colors.combine_with_groups(raw_palette)
    for name, group in palette.items():
        print(f"{name}: {len(group)} styles")

    updates_list = io_helpers.check_json_for_updates(palette)
    if updates_list:
        for color in updates_list:
            print(color)
    else:
        print("❌ No updates")

    io_helpers.write_json_to_file(palette)
    print(io_helpers.GREEN + f"\nPalette saved to {io_helpers.JSON_FILE_NAME}" + io_helpers.END)
