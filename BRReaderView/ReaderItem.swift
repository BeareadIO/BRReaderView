//
//  ReaderItem.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import Foundation
import UIKit

class ReaderItem: NSObject {
    var type: ReaderItemType!
    var data: Any?
}

enum ReaderItemType {
    case text
    case image
    case mark
}

struct ReaderImage {
    var size: CGSize = .zero
    var url: String = ""
}

struct ReaderParagraph {
    var text: String = ""
    var sort: Int = 1
}

struct ReaderMark {
    var count: Int = 1
    var sort: Int = 1
}

extension ReaderItem {
    convenience init(text: String, sort: Int) {
        self.init()
        self.type = .text
        var paragraph = ReaderParagraph()
        paragraph.text = text
        paragraph.sort = sort
        self.data = paragraph
    }
    
    convenience init(url: String) {
        self.init()
        self.type = .image
        var readerImage = ReaderImage()
        readerImage.url = url
//        let theURL = URL(string: url ?? "")
//        let query = theURL?.queryParameters ?? [:]
//        let width = query["width"]?.toDouble() ?? 0.0
//        let height = query["height"]?.toDouble() ?? 0.0
//        readerImage.size = CGSize(width: width, height: height)
        readerImage.size = CGSize(width: 1000, height: 957)
        self.data = readerImage
    }
    
    convenience init(mark count: Int) {
        self.init()
        self.type = .mark
        var readerMark = ReaderMark()
        readerMark.count = count
        self.data = readerMark
    }
    
    override var description: String {
        switch self.type! {
        case .image:
            return "Image-\((self.data as! ReaderImage).url)\n"
        case .mark:
            return "Mark\n"
        case .text:
            return "Text-\((self.data as! ReaderParagraph).sort)-\((self.data as! ReaderParagraph).text)\n"
        }
    }
}
