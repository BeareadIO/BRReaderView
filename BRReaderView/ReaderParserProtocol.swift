//
//  ReaderParserProtocol.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import Foundation

protocol ReaderParserProtocol {
    
    /// 解析文本
    ///
    /// - Parameter text: 原始文本
    /// - Returns: ReaderItem的集合
    func parseText(_ text: String) -> [ReaderItem]
}
