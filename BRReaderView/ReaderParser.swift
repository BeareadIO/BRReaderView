//
//  ReaderParser.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import Foundation
import UIKit

//* utf16.count 是为了解决包含emoji情况下的字符串个数

class ReaderParser: ReaderParserProtocol {
    /// 阅读解析器单例
    static let shared = ReaderParser()
    
    func parseText(_ text: String) -> [ReaderItem] {
        var items: [ReaderItem] = []
        let newText = ReaderHelper.shared.textReplacement(text)
        let paragraphs = logicalDivision(newText)
        for paragraph in paragraphs {
            let content = paragraph["content"] ?? ""
            let sort = (paragraph["sort"]! as NSString).integerValue
            if content == "<br>" {
                let item = ReaderItem(text: "\n", sort: sort)
                items.append(item)
                continue
            }
            if content.contains("<pic"), content.contains("</pic>") {
                parseParagraph(paragraph: content, items: &items, sort: sort)
                continue
            }
            let item = ReaderItem(text: content, sort: sort)
            items.append(item)
            let mark = ReaderItem(mark: 99)
            items.append(mark)
        }
        return items
    }
        
    /// 按照<p sort=index>标签规则进行文本逻辑切分
    ///
    /// - Parameter text: 原始文本
    /// - Returns: 切分后字符串集合
    private func logicalDivision(_ text: String) -> [[String: String]] {
        if let paragraphRegExp = try? NSRegularExpression.init(pattern: "<p sort=(.*?)>([\\s\\S]*?)</p>", options: NSRegularExpression.Options(rawValue: 0)) {
            var paragraphs: [[String: String]] = []
            paragraphRegExp.enumerateMatches(in: text, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: text.utf16.count)) { (result, flag, stop) in
                var info: [String: String] = [:]
                if let range = result?.range(at: 2) {
                    let str = (text as NSString).substring(with: range)
                    info["content"] = String(str)
                }
                if let range = result?.range(at: 1) {
                    // sort="1.2.3..." 除去双引号
                    let str = (text as NSString).substring(with: NSRange(location: range.location + 1, length: range.length - 2))
                    info["sort"] = String(str)
                }
                paragraphs.append(info)
            }
            return paragraphs
        }
        return []
    }
    
    /// 将文本内容解析成ReaderItem
    ///
    /// - Parameters:
    ///   - paragraph: 文本段落
    ///   - items: 用来储存ReaderItem的集合
    private func parseParagraph(paragraph: String, items: inout [ReaderItem], sort: Int) {
        var offset: Int = 0
        if let reg = try? NSRegularExpression.init(pattern: "<\\s*?pic\\s*?>(.*?)(</pic\\s*?>|>)", options: NSRegularExpression.Options(rawValue: 0)) {
            reg.enumerateMatches(in: paragraph, options:  NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: paragraph.utf16.count)) { (result, flag, stop) in
                if let range = result?.range {
                    if range.location == offset {
                        offset = range.length + range.location
                    } else {
                        let str = (paragraph as NSString).substring(with: NSRange(location: offset, length: range.location - offset))
                        offset = range.location + range.length
                        let item = ReaderItem(text: str, sort: sort)
                        items.append(item)
                    }
                }
                
                var url: String? = nil
                if let urlRange = result?.range(at: 1) {
                    url = (paragraph as NSString).substring(with: urlRange)
                    if url?.count == 0 {
                        url = nil
                    }
                }
                let item = ReaderItem(url: url ?? "")
                items.append(item)
            }
            if offset == paragraph.count {
                print("It's paragraph end")
            } else {
                let strStart = paragraph.index(paragraph.startIndex, offsetBy: offset)
                let strEnd = paragraph.endIndex
                let str = paragraph[strStart..<strEnd]
                let item = ReaderItem(text: String(str), sort: sort)
                items.append(item)
            }
        }
    }
}
