//
//  ReaderView.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit

class ReaderView: UITextView {

    lazy var dynamicHeight: CGFloat = {
        let height = sizeThatFits(CGSize(width: self.bounds.size.width, height: CGFloat(MAXFLOAT))).height
        return height
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        print("Function: \(#function), Line: \(#line)")
        propertyInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Function: \(#function), Line: \(#line)")
        propertyInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
         return CGSize(width: UIView.noIntrinsicMetric, height: dynamicHeight)
    }
    
    private func propertyInit() {
        isEditable = false
        layoutManager.delegate = self
        layoutManager.allowsNonContiguousLayout = true
    }
    
    private func updateHeight() {
        layoutIfNeeded()
        self.frame.size.height = dynamicHeight
        invalidateIntrinsicContentSize()
    }
}

extension ReaderView: NSLayoutManagerDelegate {
    func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return  10
    }
}

extension NSRange {
    func convertToUITextRange(with view: UITextInput) -> UITextRange {
        let beginning = view.beginningOfDocument
        let start = view.position(from: beginning, offset: location)!
        let end = view.position(from: start, offset: length)!
        let textRange = view.textRange(from: start, to: end)!
        return textRange
    }
}

extension UITextRange {
    func convertToNSRange(with view: UITextInput) -> NSRange {
        let beginning = view.beginningOfDocument
        let location = view.offset(from: beginning, to: start)
        let length = view.offset(from: start, to: end)
        let range = NSRange(location: location, length: length)
        return range
    }
}

class ReaderAttachment: NSTextAttachment {
    var view: UIView?
    var item: ReaderItem?
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
