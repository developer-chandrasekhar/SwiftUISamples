//
//  util.swift
//  PaginationSampleSwiftUI
//
//  Created by Chandra Sekhar P V on 13/12/23.
//


import UIKit
import SwiftUI

struct ColorUtil {
    static let darkGray = Color(hex: "#5C5C5C")
    static let lightGray = Color(hex: "#D2D2D2")
    static let primaryThemeColor = Color(hex: "#8A42D4")
    static let theme_color_gradient_start = Color(hex: "#8D33EA")
    static let theme_color_gradient_end = Color(hex: "#7000E2")
    static let paymentBackGround = Color(hex: "#F6EEFF")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
