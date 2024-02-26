//
//  Extensions.swift
//  SPV
//
//  Created by 王斌 on 2021/4/5.
//

import Foundation
import AppKit

extension Int64 {
    func timeStringMs() -> String {
        let ss = self / 1000
        let h = ss / 3600
        let m = (ss % 3600) / 60
        let s = (ss % 3600) % 60
        var text = ""
        if h > 0 {
            text = "\(h):"
        }
        if m < 10 {
            text += "0\(m):"
        } else {
            text += "\(m):"
        }
        if s < 10 {
            text += "0\(s)"
        } else {
            text += "\(s)"
        }
        return text
    }
}


extension NSFont {
    static func pfRegular(size: CGFloat) -> NSFont {
        guard let f = NSFont(name: "PingFangSC-Regular", size: size) else {
            return NSFont.systemFont(ofSize: size)
        }
        return f
    }
    static func pfMedium(size: CGFloat) -> NSFont {
        guard let f = NSFont(name: "PingFangSC-Medium", size: size) else {
            return NSFont.systemFont(ofSize: size)
        }
        return f
    }
    
    static func pfSemibold(size: CGFloat) -> NSFont {
        guard let f = NSFont(name: "PingFangSC-Semibold", size: size) else {
            return NSFont.systemFont(ofSize: size)
        }
        return f
    }
}
