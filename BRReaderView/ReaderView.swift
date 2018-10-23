//
//  ReaderView.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/29.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit

//open func glyphRange(forBoundingRect bounds: CGRect, in container: NSTextContainer) -> NSRange <-> NSLayoutManager Function
//binary search(half-interval search)

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
    var isMarkShow: Bool = false {
        didSet {
            parseDataArray(array: markLogicAppend(data: dataArray))
            updateHeight()
        }
    }
    
    /// 字体大小
    var fontSize: CGFloat = 15 {
        didSet {
            configureAttributes()
            updateHeight()
        }
    }
    
    /// 默认展示项（不包含马克）
    private var dataArray: [ReaderItem] = [] {
        didSet {
            parseDataArray(array: markLogicAppend(data: dataArray))
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
    
    lazy var dynamicHeight: CGFloat = {
        let height = sizeThatFits(CGSize(width: self.bounds.size.width, height: CGFloat(MAXFLOAT))).height
        return height
    }()
    
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
         return CGSize(width: UIView.noIntrinsicMetric, height: dynamicHeight)
    }
    
    private func propertyInit() {
        isEditable = false
        layoutManager.delegate = self
        layoutManager.allowsNonContiguousLayout = true
        updateHeight()
    }
    
    private func updateHeight() {
        layoutIfNeeded()
        self.frame.size.height = dynamicHeight
        invalidateIntrinsicContentSize()
    }
    
    /// 配置展示属性
    private func configureAttributes() {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.font] = UIFont.systemFont(ofSize: fontSize)
        attributes[.foregroundColor] = UIColor.lightGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = fontSize * 2
        attributes[.paragraphStyle] = paragraphStyle
        
        let range = NSRange(location: 0, length: textStorage.length)
        textStorage.addAttributes(attributes, range: range)
        
        updateHeight()
    }
    
    /// 解析阅读展示项
    ///
    /// - Parameter array: 对应展示项数组
    private func parseDataArray(array: [ReaderItem]) {
        textStorage.deleteCharacters(in: NSRange(location: 0, length: textStorage.length))
    
        for (index, item) in array.enumerated() {
            if item.type == .text {
                if let str = item.data as? String {
                    textStorage.append(NSAttributedString(string: (index != array.count - 1 ? str + "\n" : str)))
                }
            } else {
                let range = NSRange(location: textStorage.length, length: 0)
                addReaderItem(item, at: range)
            }
        }
        
        configureAttributes()
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
    }
    
    
    /// 逻辑判断添加Mark项
    ///
    /// - Parameter data: 原始阅读展示项
    /// - Returns: 最终阅读展示项
    private func markLogicAppend(data: [ReaderItem]) -> [ReaderItem] {
        guard isMarkShow else { return data }
        /// mark展示的逻辑 <p>标签后<br>之前
        return data
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
