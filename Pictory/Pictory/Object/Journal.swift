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
    var images: Array<JournalImage>
    
    init(name: String, startDate:Date, endDate:Date, images:Array<JournalImage>) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.images = images
    }
    
    func getDictionary() -> NSDictionary {
        var dictImages:[NSDictionary] = []
        for image in self.images {
            dictImages.append(image.getDictionary())
        }
        return [
            "name": self.name,
            "startDate": self.startDate.description,
            "endDate": self.endDate.description,
            "images": dictImages
        ]
    }
}
