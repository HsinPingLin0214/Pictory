//
//  JournalImage.swift
//  Pictory
//
//  Created by Jenna on 4/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit

class JournalImage: NSObject {
    var imageURL: String
    var imageDate: Date
    var imageLocation: Array<Int>
    
    init(url: String, date: Date, location: Array<Int>) {
        imageURL = url
        imageDate = date
        imageLocation = location
    }
    
    func getDictionary() -> NSDictionary {
        return [
            "imageURL": self.imageURL,
            "imageDate": self.imageDate.description,
            "imageLocation": [
                self.imageLocation[0],
                self.imageLocation[1]
            ]
        ]
    }
}
