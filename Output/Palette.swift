import UIKit

public extension UIColor {

    convenience init(
        rgbaHex: Int
    ) {
        let red = CGFloat((rgbaHex >> 24) & 0xFF) / CGFloat(0xFF)
        let green = CGFloat((rgbaHex >> 16) & 0xFF) / CGFloat(0xFF)
        let blue = CGFloat((rgbaHex >> 8) & 0xFF) / CGFloat(0xFF)
        let alpha = CGFloat((rgbaHex >> 0) & 0xFF) / CGFloat(0xFF)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    return dark
                case .light, .unspecified:
                    return light
                @unknown default:
                    return light
            }
        }
    }

    convenience init?(light: UIColor?, dark: UIColor?) {
        if let light = light,
           let dark = dark {
            self.init(light: light, dark: dark)
        } else if let light = light {
            self.init(cgColor: light.cgColor)
        } else if let dark = dark {
            self.init(cgColor: dark.cgColor)
        } else {
            return nil
        }
    }

    func resolved(with traitCollection: UITraitCollection) -> UIColor {
        return resolvedColor(with: traitCollection)
    }
}

//This file was generated automatically. Don't modify.
//swiftlint:disable identifier_name line_length
public enum Palette {

    // MARK: - All

    public enum All {

        public static var black: UIColor {
            UIColor(rgbaHex: 0x000000FF)
        }

        public static var blue100: UIColor {
            UIColor(rgbaHex: 0xD4E2FCFF)
        }

        public static var blue200: UIColor {
            UIColor(rgbaHex: 0xA0BFF9FF)
        }

        public static var blue300: UIColor {
            UIColor(rgbaHex: 0x5B91F4FF)
        }

        public static var blue400: UIColor {
            UIColor(rgbaHex: 0x276EF1FF)
        }

        public static var blue50: UIColor {
            UIColor(rgbaHex: 0xEEF3FEFF)
        }

        public static var blue500: UIColor {
            UIColor(rgbaHex: 0x1E54B7FF)
        }

        public static var blue600: UIColor {
            UIColor(rgbaHex: 0x174291FF)
        }

        public static var blue700: UIColor {
            UIColor(rgbaHex: 0x102C60FF)
        }

        public static var brown100: UIColor {
            UIColor(rgbaHex: 0xEBE0DBFF)
        }

        public static var brown200: UIColor {
            UIColor(rgbaHex: 0xD2BBB0FF)
        }

        public static var brown300: UIColor {
            UIColor(rgbaHex: 0xB18977FF)
        }

        public static var brown400: UIColor {
            UIColor(rgbaHex: 0x99644CFF)
        }

        public static var brown50: UIColor {
            UIColor(rgbaHex: 0xF7F3F1FF)
        }

        public static var brown500: UIColor {
            UIColor(rgbaHex: 0x744C3AFF)
        }

        public static var brown600: UIColor {
            UIColor(rgbaHex: 0x5C3C2EFF)
        }

        public static var brown700: UIColor {
            UIColor(rgbaHex: 0x3D281EFF)
        }

        public static var gray100: UIColor {
            UIColor(rgbaHex: 0xEEEEEEFF)
        }

        public static var gray200: UIColor {
            UIColor(rgbaHex: 0xE2E2E2FF)
        }

        public static var gray300: UIColor {
            UIColor(rgbaHex: 0xCBCBCBFF)
        }

        public static var gray400: UIColor {
            UIColor(rgbaHex: 0xAFAFAFFF)
        }

        public static var gray50: UIColor {
            UIColor(rgbaHex: 0xF6F6F6FF)
        }

        public static var gray500: UIColor {
            UIColor(rgbaHex: 0x757575FF)
        }

        public static var gray600: UIColor {
            UIColor(rgbaHex: 0x545454FF)
        }

        public static var gray700: UIColor {
            UIColor(rgbaHex: 0x333333FF)
        }

        public static var green100: UIColor {
            UIColor(rgbaHex: 0xDAF0E3FF)
        }

        public static var green200: UIColor {
            UIColor(rgbaHex: 0xAEDDC2FF)
        }

        public static var green300: UIColor {
            UIColor(rgbaHex: 0x73C496FF)
        }

        public static var green400: UIColor {
            UIColor(rgbaHex: 0x3AA76DFF)
        }

        public static var green50: UIColor {
            UIColor(rgbaHex: 0xF0F9F4FF)
        }

        public static var green500: UIColor {
            UIColor(rgbaHex: 0x368759FF)
        }

        public static var green600: UIColor {
            UIColor(rgbaHex: 0x2B6B46FF)
        }

        public static var green700: UIColor {
            UIColor(rgbaHex: 0x1C472FFF)
        }

        public static var orange100: UIColor {
            UIColor(rgbaHex: 0xFBE2D6FF)
        }

        public static var orange200: UIColor {
            UIColor(rgbaHex: 0xF7BFA5FF)
        }

        public static var orange300: UIColor {
            UIColor(rgbaHex: 0xF19164FF)
        }

        public static var orange400: UIColor {
            UIColor(rgbaHex: 0xED6E33FF)
        }

        public static var orange50: UIColor {
            UIColor(rgbaHex: 0xFEF3EFFF)
        }

        public static var orange500: UIColor {
            UIColor(rgbaHex: 0xB45427FF)
        }

        public static var orange600: UIColor {
            UIColor(rgbaHex: 0x8E421FFF)
        }

        public static var orange700: UIColor {
            UIColor(rgbaHex: 0x5F2C14FF)
        }

        public static var purple100: UIColor {
            UIColor(rgbaHex: 0xE3DDF2FF)
        }

        public static var purple200: UIColor {
            UIColor(rgbaHex: 0xC1B5E3FF)
        }

        public static var purple300: UIColor {
            UIColor(rgbaHex: 0x957FCEFF)
        }

        public static var purple400: UIColor {
            UIColor(rgbaHex: 0x7356BFFF)
        }

        public static var purple50: UIColor {
            UIColor(rgbaHex: 0xF4F1FAFF)
        }

        public static var purple500: UIColor {
            UIColor(rgbaHex: 0x574191FF)
        }

        public static var purple600: UIColor {
            UIColor(rgbaHex: 0x453473FF)
        }

        public static var purple700: UIColor {
            UIColor(rgbaHex: 0x2E224CFF)
        }

        public static var red100: UIColor {
            UIColor(rgbaHex: 0xFADBD7FF)
        }

        public static var red200: UIColor {
            UIColor(rgbaHex: 0xF4AFA7FF)
        }

        public static var red300: UIColor {
            UIColor(rgbaHex: 0xEB7567FF)
        }

        public static var red400: UIColor {
            UIColor(rgbaHex: 0xD44333FF)
        }

        public static var red50: UIColor {
            UIColor(rgbaHex: 0xFDF0EFFF)
        }

        public static var red500: UIColor {
            UIColor(rgbaHex: 0xAE372AFF)
        }

        public static var red600: UIColor {
            UIColor(rgbaHex: 0x892C21FF)
        }

        public static var red700: UIColor {
            UIColor(rgbaHex: 0x5C1D16FF)
        }

        public static var white: UIColor {
            UIColor(rgbaHex: 0xFFFFFFFF)
        }

        public static var yellow100: UIColor {
            UIColor(rgbaHex: 0xFFF2D9FF)
        }

        public static var yellow200: UIColor {
            UIColor(rgbaHex: 0xFFE3ACFF)
        }

        public static var yellow300: UIColor {
            UIColor(rgbaHex: 0xFFCF70FF)
        }

        public static var yellow400: UIColor {
            UIColor(rgbaHex: 0xFFC043FF)
        }

        public static var yellow50: UIColor {
            UIColor(rgbaHex: 0xFFFAF0FF)
        }

        public static var yellow500: UIColor {
            UIColor(rgbaHex: 0xBC8B2CFF)
        }

        public static var yellow600: UIColor {
            UIColor(rgbaHex: 0x997328FF)
        }

        public static var yellow700: UIColor {
            UIColor(rgbaHex: 0x664D1BFF)
        }
    }

    // MARK: - Gray

    public enum Gray {

        public static var tone100: UIColor {
            UIColor(rgbaHex: 0xEEEEEEFF)
        }

        public static var tone200: UIColor {
            UIColor(rgbaHex: 0xE2E2E2FF)
        }

        public static var tone400: UIColor {
            UIColor(rgbaHex: 0xAFAFAFFF)
        }

        public static var tone50: UIColor {
            UIColor(rgbaHex: 0xF6F6F6FF)
        }

        public static var tone500: UIColor {
            UIColor(rgbaHex: 0x757575FF)
        }

        public static var tone600: UIColor {
            UIColor(rgbaHex: 0x545454FF)
        }
    }

    // MARK: - Primary

    public enum Primary {

        public static var black: UIColor {
            UIColor(rgbaHex: 0x000000FF)
        }

        public static var white: UIColor {
            UIColor(rgbaHex: 0xFFFFFFFF)
        }
    }

    // MARK: - Secondary

    public enum Secondary {

        public static var blue: UIColor {
            UIColor(rgbaHex: 0x276EF1FF)
        }

        public static var brown: UIColor {
            UIColor(rgbaHex: 0x99644CFF)
        }

        public static var green: UIColor {
            UIColor(rgbaHex: 0x3AA76DFF)
        }

        public static var orange: UIColor {
            UIColor(rgbaHex: 0xED6E33FF)
        }

        public static var purple: UIColor {
            UIColor(rgbaHex: 0x7356BFFF)
        }

        public static var red: UIColor {
            UIColor(rgbaHex: 0xD44333FF)
        }

        public static var yellow: UIColor {
            UIColor(rgbaHex: 0xFFC043FF)
        }
    }
}
