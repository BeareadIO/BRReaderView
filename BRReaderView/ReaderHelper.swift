//
//  ReaderHelper.swift
//  BRReaderView
//
//  Created by Archy on 2018/10/23.
//  Copyright © 2018 Archy. All rights reserved.
//

import Foundation

class ReaderHelper {
    static let shared = ReaderHelper()

    func flatFormattedString(text: String) -> String {
        var flatText = ""
        if let reg = try? NSRegularExpression.init(pattern: "<p sort=(.*?)>([\\s\\S]*?)</p>", options: NSRegularExpression.Options(rawValue: 0)) {
            let range = NSRange(location: 0, length: (text as NSString).length)
            flatText = reg.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "$2")
        }
        flatText = textReplacement(flatText)
        flatText = flatText.replacingOccurrences(of: "<br>", with: "\n")
        if let reg = try? NSRegularExpression.init(pattern: "(<pic.*/pic>)", options: NSRegularExpression.Options(rawValue: 0)) {
            let range = NSRange(location: 0, length: (flatText as NSString).length)
            flatText = reg.stringByReplacingMatches(in: flatText, options: [], range: range, withTemplate: "\u{fffc}")
        }
        return flatText
    }
    
    func convertInfo(range: NSRange, content: String) -> [String: String] {
        
        return [:]
    }
    
    /// 替换文本网页特殊标签
    ///
    /// - Parameter text: 原始文本
    /// - Returns: 替换后文本
    func textReplacement(_ text: String) -> String {
        var newText = text.replacingOccurrences(of: "&nbsp;", with: " ")
        newText = newText.replacingOccurrences(of: "&lt;", with: "<")
        newText = newText.replacingOccurrences(of: "&gt;", with: ">")
        newText = newText.replacingOccurrences(of: "&amp;", with: "&")
        newText = newText.replacingOccurrences(of: "&quot;", with: "\"")
        newText = newText.replacingOccurrences(of: "&copy;", with: "©")
        newText = newText.replacingOccurrences(of: "\r\n", with: "\n")
        newText = newText.replacingOccurrences(of: "\r", with: "\n")
        newText = newText.replacingOccurrences(of: "\u{2028}", with: "\n")
        newText = newText.replacingOccurrences(of: "\u{2029}", with: "\n")
        newText = newText.replacingOccurrences(of: "\t", with: " ")
        return newText
    }

}
