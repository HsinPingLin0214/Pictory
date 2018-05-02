//
//  Journal.swift
//  Pictory
//
//  Created by Jenna on 2/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit

class Journal: NSObject {
    var name:String
    var startDate:Date
    var endDate:Date
    
    init(name: String, startDate:Date, endDate:Date) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
    }

}
