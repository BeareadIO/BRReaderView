//
//  ReaderParserProtocol.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import Foundation

protocol ReaderParserProtocol {
    func parseText(_ text: String) -> [ReaderItem]
}
