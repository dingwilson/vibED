//
//  FirebaseObject.swift
//  vibED
//
//  Created by Wilson Ding on 9/27/15.
//  Copyright © 2015 Wilson Ding. All rights reserved.
//

import Foundation

class FirebaseObject {
    var date_ : NSDate
    var value_ : Int
    
    init(date: NSDate, value: Int) {
        self.date_ = date
        self.value_ = value
    }
    
    func date() -> NSDate! {
        return date_
    }
    
    func value() -> Int! {
        return value_
    }
}