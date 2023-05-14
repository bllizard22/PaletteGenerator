import Foundation
import Stencil
import PathKit

final class Generator {
    private enum ColorType: String {
        case cgColor = "CGColor"
        case uiColor = "UIColor"
    }

    private enum TerminalColors {
        static let green = "\u{001B}[0;32m"
        static let warn = "\u{001B}[0;33m"
        static let fail = "\u{001B}[0;31m"
        static let end = "\u{001B}[0;0m"
    }

    private enum FilePath: String {
        case generateColors = "./Output"
        case figmaJSON = "./Output/figma.json"
        case stencilDir = "./Project/Sources/PaletteGenerator/Stencils/"
    }

    private enum Stencil {
        private static let fileExt = ".stencil"
        static let palette = "Palette" + fileExt
        static let group = "Group" + fileExt
        static let token = "Token" + fileExt
        static let staticColor = "StaticColor" + fileExt
        static let themedColor = "ThemedColor" + fileExt
        static let solidColor = "SolidColor" + fileExt
        static let gradientColor = "GradientColor" + fileExt
    }

    private let fileManager = FileManager.default
    private lazy var enviroment = Environment(loader: FileSystemLoader(paths: [
        Path(URL(fileURLWithPath: FilePath.stencilDir.rawValue).relativeString)
    ]))

    // MARK: - Public Methods

    func run() {
        guard let json = readJSONFile() else {
            prettyPrint("Error with JSON read")
            return
        }

        var output = ""
        output.append(getRendered(from: [:], template: Stencil.palette))

        for (group, groupValue) in json.sorted(by: { $0.0 < $1.0 }) {
            output.append(getRendered(from: ["group": group], template: Stencil.group))
            if let tokens = groupValue as? [String: Any] {

                for (token, tokenValue) in tokens.sorted(by: { $0.0 < $1.0 }) {
                    let tokenLine = getRenderedToken(from: ["token": token, "details": tokenValue])
                    output.append(tokenLine.replacingOccurrences(of: " \n", with: "\n"))
                    if let styles = tokenValue as? [String: Any] {
                        let style = styles["style"] as! String
                        switch style {
                            case "SOLID":
                                output.append(getRenderedSolid(from: styles))
                            case "GRADIENT_LINEAR", "GRADIENT_ANGULAR":
                                output.append(getRenderedGradient(from: styles))
                            default:
                                prettyPrint("Error with style - \(style)")
                        }
                    }
                }
            }
            output.append("    }\n")
        }
        output.append("}\n")

        writeSwiftCode(name: "Palette", swiftCode: output)
    }

    // MARK: - Private Methods

    private func readJSONFile() -> [String: Any]? {
        let url = URL(fileURLWithPath: FilePath.figmaJSON.rawValue)
        guard
            let data = try? Data(contentsOf: url, options: .mappedIfSafe),
            let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        else {
            return nil
        }

        return jsonResult as? [String: Any]
    }

    private func getRendered(from dict: [String: Any], template: String) -> String {
        let context = Context(dictionary: dict)
        var output = ""
        do {
            output = try enviroment.renderTemplate(
                name: template,
                context: context.flatten()
            )
        } catch {
            prettyPrint("Error (template): \(error)")
        }

        return output
    }

    private func getRenderedToken(from dict: [String: Any]) -> String {
        var newdict = dict
        if newdict["token"] as? String == "default" {
            newdict["token"] = "`default`"
        }
        let context = Context(dictionary: newdict)
        var output = ""
        do {
            output = try enviroment.renderTemplate(
                name: Stencil.token,
                context: context.flatten()
            )
        } catch {
            prettyPrint("Error (Token): \(error)")
        }

        return output
    }

    private func getColor(from dict: [String: Any], withType type: ColorType) -> String {
        if
            let light = dict["light"] as? String,
            let dark = dict["dark"] as? String,
            light != "null",
            dark != "null" {
            return getThemedColor(from: dict, withType: type)
        } else {
            return getStaticColor(from: dict, withType: type)
        }
    }

    private func getStaticColor(from dict: [String: Any], withType type: ColorType) -> String {
        var newdict = [String: Any]()
        if let light = dict["light"] ?? dict["dark"] {
            newdict["color"] = light
        } else {
            return "colorError"
        }
        newdict["cgColor"] = type == .cgColor ? ".cgColor" : ""
        let context = Context(dictionary: newdict)
        var output = ""
        do {
            output = try enviroment.renderTemplate(
                name: Stencil.staticColor,
                context: context.flatten()
            )

        } catch {
            prettyPrint("Error (ThemedColor): \(error)")
        }

        return output
    }

    private func getThemedColor(from dict: [String: Any], withType type: ColorType) -> String {
        var newdict = dict
        newdict["cgColor"] = type == .cgColor ? ".cgColor" : ""
        let context = Context(dictionary: newdict)
        var output = ""
        do {
            output = try enviroment.renderTemplate(
                name: Stencil.themedColor,
                context: context.flatten()
            )
        } catch {
            prettyPrint("Error (ThemedColor): \(error)")
        }

        return output
    }

    private func getRenderedSolid(from dict: [String: Any]) -> String {
        guard let colors = dict["colors"] as? [[String: Any]] else {
            prettyPrint("Error with colors in \(dict)")
            return ""
        }

        var newdict = dict
        newdict["color"] = getColor(from: colors[0], withType: .uiColor).dropLast(1)
        let context = Context(dictionary: newdict)
        var output = ""
        do {
            output = try enviroment.renderTemplate(
                name: Stencil.solidColor,
                context: context.flatten()
            )
        } catch {
            prettyPrint("Error (SolidColor): \(error)")
        }

        return output
    }

    private func getRenderedGradient(from dict: [String: Any]) -> String {
        var newdict = dict
        guard let colors = dict["colors"] as? [[String: Any]] else {
            prettyPrint("Error with colors in \(dict)")
            return ""
        }

        var colorsRaw = [String]()
        for (index, color) in colors.enumerated() {
            var value = color
            if index != colors.endIndex-1 {
                value["separator"] = ","
            }
            colorsRaw.append(getColor(from: value, withType: .uiColor))
        }
        colorsRaw.indices.last.map { colorsRaw[$0] = String(colorsRaw[$0].dropLast(1)) }
        newdict["colors"] = colorsRaw
        newdict["positions"] = (dict["positions"] as! [String]).joined(separator: ", ")
        let context = Context(dictionary: newdict)
        var output = ""
        do {
            output = try enviroment.renderTemplate(
                name: Stencil.gradientColor,
                context: context.flatten()
            )
        } catch {
            prettyPrint("Error (GradientColor): \(error)")
        }

        return output
    }

    private func writeSwiftCode(name: String, swiftCode: String) {
        if !(fileManager.fileExists(atPath: FilePath.generateColors.rawValue)) {
            do {
                try fileManager.createDirectory(atPath: FilePath.generateColors.rawValue, withIntermediateDirectories: true)
            } catch {
                prettyPrint("Error with creating dir: \(error)")
            }
        }
        let fileUrl = URL(fileURLWithPath: FilePath.generateColors.rawValue)
            .appendingPathComponent(name)
            .appendingPathExtension("swift")

        do {
            try swiftCode.write(to: fileUrl, atomically: true, encoding: .utf8)
            prettyPrint("Done!", style: TerminalColors.green)
        } catch {
            prettyPrint("Error with saving file: \(error)")
        }
    }

    private func prettyPrint(_ line: String, style: String = TerminalColors.fail) {
        print(style + line + TerminalColors.end)
    }
}
