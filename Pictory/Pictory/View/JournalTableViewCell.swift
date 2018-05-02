//
//  JournalTableViewCell.swift
//  Pictory
//
//  Created by Jenna on 2/5/18.
//  Copyright © 2018 Hsin-Ping Lin. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    @IBOutlet weak var timelineIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
