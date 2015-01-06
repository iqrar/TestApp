//
//  Data.swift
//  TestApp
//
//  Created by iqrar haider on 1/6/15.
//  Copyright (c) 2015 iqrar haider. All rights reserved.
//

import Foundation

class Loan {
    
    var name:String = ""
    var des:String = ""
    var hrefString: String = ""
    var title:String = ""
    
    init(name:String, des:String, hrefString:String){
        self.name = name
        self.des = des
        self.hrefString = hrefString
    }
}