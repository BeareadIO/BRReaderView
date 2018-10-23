//
//  ViewController.swift
//  BRReaderView
//
//  Created by Archy on 2018/9/14.
//  Copyright © 2018 Archy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: BRReaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(textView.frame.height)
    }

}

