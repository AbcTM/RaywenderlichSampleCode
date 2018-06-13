//
//  BookCellView.swift
//  BookShop
//
//  Created by tm on 2018/6/13.
//  Copyright © 2018年 tm. All rights reserved.
//

import Cocoa


/// 自定义书本cell
class BookCellView: NSTableCellView {

    @IBOutlet weak var coverImage: NSImageView!
    @IBOutlet weak var bookTitle: NSTextField!
    
    override var backgroundStyle: NSView.BackgroundStyle {
        didSet {
            switch backgroundStyle {
            case .dark:
                bookTitle.textColor = NSColor.white
            default:
                bookTitle.textColor = NSColor.black
            }
        }
    }
    
}
