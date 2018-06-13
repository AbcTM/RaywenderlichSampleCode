//
//  Book.swift
//  BookShop
//
//  Created by tm on 2018/6/13.
//  Copyright © 2018年 tm. All rights reserved.
//

import Foundation


/// 书的结构
struct Book {
    
    let title: String
    let cover: String
    let edition: String
    let url: URL
    
    var thumb: String {
        return cover + "_t"
    }
    
    // 获取plist所有书
    static func all() -> [Book] {
        return NSArray(contentsOfFile: Bundle.main.path(forResource: "Books", ofType: "plist")!)!.map({ row in
            let book = row as! [String:String]
            return Book.init(title: book["title"]!, cover: book["cover"]!, edition: book["edition"]!, url: URL.init(string: book["url"]!)!)
        })
    }
}
