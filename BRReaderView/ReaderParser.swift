//
//  ReaderParser.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import Foundation
import UIKit

class ReaderParser: ReaderParserProtocol {
    static let shared = ReaderParser()
    
    func parseText(_ text: String) -> [ReaderItem] {
        var items: [ReaderItem] = []
        let newText = textReplacement(text)
        let paragraphs = logicalDivision(newText)
        for paragraph in paragraphs {
            if paragraph == "<br>" {
                let item = ReaderItem(text: "")
                items.append(item)
            }
        }
        return items
    }
    
    private func textReplacement(_ text: String) -> String {
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
    
    private func logicalDivision(_ text: String) -> [String] {
        if let paragraphRegExp = try? NSRegularExpression.init(pattern: "<p sort=(.*?)>([\\s\\S]*?)</p>", options: NSRegularExpression.Options(rawValue: 0)) {
            var paragraphs: [String] = []
            paragraphRegExp.enumerateMatches(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: text.utf16.count)) { (result, flag, stop) in
                if let range = result?.range(at: 2) {
                    let str = (text as NSString).substring(with: range)
                    paragraphs.append(String(str))
                }
            }
            return paragraphs
        }
        return []
    }
    
    private enum ParagraphParseType {
        case img
        case pic
        
        var regular: NSRegularExpression? {
            switch self {
            case .img: return try? NSRegularExpression.init(pattern: "<\\s*img src=\"data:image/(?:jpeg|png|jpg);base64,(.*?)\"\\s*/>", options: NSRegularExpression.Options(rawValue: 0))
            case .pic: return try? NSRegularExpression.init(pattern: "<pic(.*?)>(.*?)</pic>", options: NSRegularExpression.Options(rawValue: 0))
            }
        }
    }
}
