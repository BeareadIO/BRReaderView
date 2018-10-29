//
//  ReaderImageComponentView.swift
//  BRReaderView
//
//  Created by Archy on 2018/10/24.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit
import Kingfisher

class ReaderImageComponentView: UIView {

    @IBOutlet weak var imgViewImage: UIImageView!
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var btnReload: UIButton!
    
    @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    var data: Any? {
        didSet {
            if let item = data as? ReaderImage {
                adjustSize(item)
                loadImage(item)
            }
        }
    }
    
    fileprivate func adjustSize(_ item: ReaderImage) {
        var size: CGSize = CGSize(width: UIScreen.main.bounds.size.width - 15 * 2, height: 200)
        if item.size != .zero {
            size = item.size
        }
        let imageWidth = size.width / 2
        let imageHeight = size.height / 2
        let maxWidth = UIScreen.main.bounds.width - 15 * 2
        if imageWidth > maxWidth {
            size = CGSize(width: maxWidth, height: imageHeight * (maxWidth / imageWidth))
        } else {
            size = CGSize(width: imageWidth, height: imageHeight)
        }
        let height = size.height + containerTopConstraint.constant + containerBottomConstraint.constant
        bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        imageWidthConstraint.constant = size.width
    }
    
    func loadImage(_ item: ReaderImage) {
        placeHolderView.isHidden = false
        lblState.text = "图片加载中..."
        btnReload.isHidden = true
        imgViewImage.kf.setImage(with: URL(string: item.url)) { [weak self] (image, error, cacheType, url) in
            guard let `self` = self else { return }
            if error != nil {
                self.lblState.text = "图片加载失败，点击"
                self.btnReload.isHidden = false
                return
            }
            self.placeHolderView.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override var frame: CGRect {
        didSet {
            print(frame)
        }
    }
}
