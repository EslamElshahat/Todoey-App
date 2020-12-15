//
//  item.swift
//  Todoey
//
//  Created by Eslam Elshaht on 11/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//class Item {
//    let title: String
//    let done: Bool
////
////    init(title: String, done:Bool) {
////        self.title = title
////        self.done = done
////        super.init()
////    }
////
////    // MARK: - NSCoding protocol required methods
////    required convenience init?(coder aDecoder: NSCoder) {
////        guard let title = aDecoder.decodeObject(forKey: "title") as? String else { return nil }
////        guard let done = aDecoder.decodeObject(forKey: "done") as? Bool else { return nil }
////        self.init(title: title,done: done)
////    }
////
////    func encodeWithCoder(aCoder: NSCoder) {
////        aCoder.encode(title, forKey: "name")
////        aCoder.encode(done, forKey: "done")
////    }
//}
class  Item: Codable {
    var title: String = ""
    var done: Bool = false
    
    
}
