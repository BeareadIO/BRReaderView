//
//  ReaderMarkComponentView.swift
//  BRReaderView
//
//  Created by Archy on 2018/10/24.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit

class ReaderMarkComponentView: UIView {

    @IBOutlet weak var lblCount: UILabel!

    var data: Any? {
        didSet {
            guard let item = data as? ReaderMark else { return }
            print(item)
        }
    }
}
