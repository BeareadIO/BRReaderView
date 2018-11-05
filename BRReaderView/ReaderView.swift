//
//  ReaderView.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit
import TinyConstraints

//open func glyphRange(forBoundingRect bounds: CGRect, in container: NSTextContainer) -> NSRange <-> NSLayoutManager Function
//binary search(half-interval search)

fileprivate let defaultMarkWidth: CGFloat = 16.0
fileprivate let maxMarkWidth: CGFloat = 24.0

protocol ReaderViewDelegate: UITextViewDelegate {
    /// 返回阅读器中的图片，或者马克
    ///
    /// - Parameters:
    ///   - readerView: 阅读器
    ///   - item: 视图对应展示项
    ///   - range: 视图对应反应
    /// - Returns: 对应视图
    func readerView(_ readerView: ReaderView, viewForItem item: ReaderItem, at range: NSRange) -> UIView
}

class ReaderView: UITextView {

    /// 是否显示马克
    var isMarkShow: Bool = true {
        didSet {
            updateHeight()
        }
    }
    
    var isFirstLineIndent: Bool = true {
        didSet {
            configureAttributes()
            updateHeight()
        }
    }
    
    /// 字体大小
    var fontSize: CGFloat = 21 {
        didSet {
            configureAttributes()
            updateHeight()
        }
    }
    
    /// 默认展示项（不包含马克）
    private var dataArray: [ReaderItem] = [] {
        didSet {
            parseDataArray(array: dataArray)
            updateHeight()
        }
    }
    
    /// 格式化字符串
    var formattedString: String = "" {
        didSet {
            dataArray = parser!.parseText(formattedString)
        }
    }
    
    /// 阅读解析器
    var parser: ReaderParserProtocol?
    
    var readerViewDelegate: ReaderViewDelegate?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
         return CGSize(width: UIView.noIntrinsicMetric, height: sizeThatFits(CGSize(width: self.bounds.size.width, height: CGFloat(MAXFLOAT))).height)
    }
    
    private func propertyInit() {
        isEditable = false
        isSelectable = true
        isScrollEnabled = false
        layoutManager.delegate = self
        layoutManager.allowsNonContiguousLayout = false
        updateHeight()
    }
    
    private func updateHeight() {
        layoutIfNeeded()
        self.frame.size.height = sizeThatFits(CGSize(width: self.bounds.size.width, height: CGFloat(MAXFLOAT))).height
        invalidateIntrinsicContentSize()
    }
    
    /// 配置展示属性
    private func configureAttributes() {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.font] = UIFont.systemFont(ofSize: fontSize)
        attributes[.foregroundColor] = UIColor.black
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = isFirstLineIndent ? fontSize * 2 : 0
        attributes[.paragraphStyle] = paragraphStyle
        
        var linkAttributes: [NSAttributedString.Key: Any] = [:]
        linkAttributes[.font] = UIFont.systemFont(ofSize: fontSize)
        linkAttributes[.foregroundColor] = UIColor.black
        linkAttributes[.paragraphStyle] = paragraphStyle
        
        self.linkTextAttributes = linkAttributes
        
        let range = NSRange(location: 0, length: textStorage.length)
        textStorage.addAttributes(attributes, range: range)
        
        updateHeight()
    }
    
    /// 解析阅读展示项
    ///
    /// - Parameter array: 对应展示项数组
    private func parseDataArray(array: [ReaderItem]) {
        textStorage.deleteCharacters(in: NSRange(location: 0, length: textStorage.length))
    
        for item in array {
            if item.type == .text {
                if let paragraph = item.data as? ReaderParagraph {
                    textStorage.append(NSAttributedString(string: paragraph.text))
                }
            } else {
                let range = NSRange(location: textStorage.length, length: 0)
                addReaderItem(item, at: range)
            }
        }
        
        configureAttributes()
        updateComponentLayout()
        updateHeight()
    }
    
    /// 添加自定义视图
    ///
    /// - Parameters:
    ///   - readerItem: 对应阅读展示项
    ///   - range: 对应位置
    private func addReaderItem(_ readerItem: ReaderItem, at range: NSRange) {
        guard let customView = readerViewDelegate?.readerView(self, viewForItem: readerItem, at: range) else {
            assertionFailure("Please implement readerViewDelegate")
            return
        }
        
        addSubview(customView)
        
        let attachment = ReaderAttachment(data: nil, ofType: nil)
        if readerItem.type == .image {
            let width = UIScreen.main.bounds.width - textContainer.lineFragmentPadding * 2
            attachment.bounds = CGRect(x: 0, y: 0, width: width, height: customView.frame.size.height)
        } else if readerItem.type == .mark {
            var width: CGFloat = 0
            if let mark = readerItem.data as? ReaderMark {
                width = (mark.count == 0) ? 0 : (isMarkShow ? ( mark.count > 99 ? maxMarkWidth : defaultMarkWidth ) : 0)
            }
            attachment.bounds = CGRect(x: 0, y: 0, width: width > 16 ? (width + 6) : width, height: 16)
        }
        attachment.item = readerItem
        attachment.view = customView
        
        let insertedAttrText = NSMutableAttributedString()
        let currentLocation = range.location + range.length
        
        insertedAttrText.append(NSAttributedString(attachment: attachment))
        textStorage.insert(insertedAttrText, at: currentLocation)
    }
    
    /// 更新组件布局
    private func updateComponentLayout() {
        let contentRange = NSRange(location: 0, length: textStorage.length)
        textStorage.enumerateAttribute(NSAttributedString.Key.attachment, in: contentRange) { [weak self] (attribute, range, _) in
            guard let `self` = self else { return }
            if let attachment = attribute as? ReaderAttachment {
                if attachment.item?.type == .image {
                    if let v = attachment.view {
                        let textRange = range.convertToUITextRange(with: self)
                        let rect = firstRect(for: textRange)
                        v.leftToSuperview(offset: 0)
                        v.topToSuperview(offset: rect.minY)
                        v.width(UIScreen.main.bounds.width)
                        v.height(rect.height - 1.5)
                    }
                } else if attachment.item?.type == .mark {
                    if let v = attachment.view, let mark = attachment.item?.data as? ReaderMark {
                        let textRange = range.convertToUITextRange(with: self)
                        let rect = firstRect(for: textRange)
                        let height = UIFont.systemFont(ofSize: fontSize).pointSize + 10 // lineSpacing
                        v.leftToSuperview(offset: rect.minX)
                        v.topToSuperview(offset: rect.minY + (height - 16) / 2.0)
                        v.width((mark.count == 0) ? 0 : (isMarkShow ? ( mark.count > 99 ? maxMarkWidth : defaultMarkWidth ) : 0))
                        v.height(16)
                    }
                }
            }
        }
    }
    
    /// 马克阅读文本
    ///
    /// - Parameter range: 马克范围
    func markReaderContent(range: NSRange) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.backgroundColor] = UIColor.lightGray
        attributes[.font] = UIFont.systemFont(ofSize: fontSize)
        attributes[.link] = "reader://"
        attributes[.foregroundColor] = UIColor.black
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = isFirstLineIndent ? fontSize * 2 : 0
        attributes[.paragraphStyle] = paragraphStyle
        textStorage.setAttributes(attributes, range: range)
        self.selectedRange = NSRange(location: 0, length: 0)
    }
    
    /// 取消马克阅读文本
    ///
    /// - Parameter range: 马克范围
    func unmarkReaderContent(range: NSRange) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.font] = UIFont.systemFont(ofSize: fontSize)
        attributes[.foregroundColor] = UIColor.black
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = isFirstLineIndent ? fontSize * 2 : 0
        attributes[.paragraphStyle] = paragraphStyle
        textStorage.setAttributes(attributes, range: range)
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
