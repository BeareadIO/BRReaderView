//
//  BRReaderView.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit

class BRReaderView: ReaderView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        menuInit()
    }
    
    private func menuInit() {
        let markMenuItem = UIMenuItem(title: "马克此段", action: #selector(markContent))
        UIMenuController.shared.menuItems = [markMenuItem]
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(markContent), selectedRange.length != 0 {
            return true
        }
        return false
    }
    
    @objc func markContent() {
        self.markReaderContent(range: self.selectedRange)
    }
}
