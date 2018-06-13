//
//  ViewController.swift
//  BookShop
//
//  Created by tm on 2018/6/13.
//  Copyright © 2018年 tm. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var coverImageView: NSImageView!
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var editionTextField: NSTextField!
    @IBOutlet weak var publisherTextField: NSTextField!
    
    // MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // 在main.storyboard window ViewController 添加toolbar, 并全部删除，添加image toolbar item（配置文字图片以及响应的方法）和flexible space toolbar item.并设置默认的items
        // 在main.storyboard设置tableview delegate和datasource
        // 在main.storyboard自定义tableview cell cell类型为text table cell View 删除NSTextField,自定义content
        // table view 在属性检查器取消勾选headers
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBOutlet weak var topStack: NSStackView!
    
    let books = Book.all()
    
    // toolbar item 响应时间
    @IBAction func actionToggleListView(sender: AnyObject) {
        // 设置item状态
        if let button = sender as? NSToolbarItem {
            switch button.tag {
            case 0:
                button.tag = 1
                button.image = NSImage(named: NSImage.Name(rawValue: "list-selected-icon"))
            case 1:
                button.tag = 0
                button.image = NSImage(named: NSImage.Name(rawValue: "list-icon"))
            default: break
            }
            
            //toggle the side bar visibility
            // 动画组
            NSAnimationContext.runAnimationGroup({context in
                context.duration = 0.25
                context.allowsImplicitAnimation = true
                // 列表栏隐藏或者显示
                self.topStack.arrangedSubviews.first!.isHidden = button.tag==0 ? true : false
                self.view.layoutSubtreeIfNeeded()
                
            }, completionHandler: nil)
        }
    }
}

//
//  Starter code
//
extension ViewController {
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let window = view.window {
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.isMovableByWindowBackground = true
        }
        view.wantsLayer = true
        view.layer!.backgroundColor = NSColor(calibratedWhite: 0.95, alpha: 1).cgColor
        
        tableView.selectRowIndexes(IndexSet.init(integer: 0), byExtendingSelection: false)
        displayBookDetails(book: books[tableView.selectedRow])
    }
    
    /// 显示本的详情
    ///
    /// - Parameter book: book
    func displayBookDetails(book: Book) {
        coverImageView.image = NSImage(named: NSImage.Name(rawValue: book.cover))
        titleTextField.stringValue = book.title
        editionTextField.stringValue = book.edition
        publisherTextField.stringValue = book.cover
    }
    
    /// 点击购买事件
    @IBAction func actionBuySelectedBook(sender: AnyObject) {
        let book = books[tableView.selectedRow]
        NSWorkspace.shared.open(book.url)
    }
}

//
//  Table view code
//
extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "BookCell"), owner: self) as! BookCellView
        let book = books[row]
        
        cell.coverImage.image = NSImage(named: NSImage.Name(rawValue: book.thumb))
        cell.bookTitle.stringValue = book.title
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        displayBookDetails(book: books[row])
        return true
    }
    
}

