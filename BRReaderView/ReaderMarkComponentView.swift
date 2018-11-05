//
//  ReaderMarkComponentView.swift
//  BRReaderView
//
//  Created by Archy on 2018/10/24.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit

struct Mark: Codable {
    let id: Int
    let bContent: String
    let capContent: String
    let num: Int
    let snum: Int
    private enum CodingKeys: String, CodingKey {
        case id
        case bContent = "b_content"
        case capContent = "cap_content"
        case num
        case snum
    }
}

class ReaderMarkComponentView: UIView {

    @IBOutlet weak var lblCount: UILabel!

    var data: Any? {
        didSet {
            guard let item = data as? ReaderMark else { return }
            lblCount.text = item.count > 99 ? "99+" : "\(item.count)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCount.layer.cornerRadius = 8
    }
}
