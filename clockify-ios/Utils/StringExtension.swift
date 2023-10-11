//
//  StringExtension.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 11/10/23.
//

import Foundation

class StringExtension {
    
    static func padZeroOnLeft(s: Int, length: Int) -> String {
        let padZeroSize = max(0, length - String(s).count)
        let newStr = String(repeating: "0", count: padZeroSize) + String(s)
        return newStr
     }
}
