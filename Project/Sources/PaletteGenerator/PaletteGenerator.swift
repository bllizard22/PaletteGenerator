@main
struct PaletteGenerator {

    /// Update styles from Figma and generate Palette
    /// This command executes colors-generator.py to obtain up-to-date styles and then generate Palette.swift
    static func main() {
        run()
    }

    static func run() {
        print("Fetching styles from FIGMA...")

        do {
            let output = try Shell.run("cd ./tools/" + "\n" + "./update-colors.sh")
            print(output ?? "Done. No Changes")
        } catch {
            print("\(error)")
            return
        }

        print("Generating Palette...")
        let colorsGenerator = Generator()

        colorsGenerator.run()

    }
}
