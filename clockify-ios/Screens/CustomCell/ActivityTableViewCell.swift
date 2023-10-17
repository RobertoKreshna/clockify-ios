//
//  ActivityTableViewCell.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 11/10/23.
//

import UIKit
import SwipeCellKit

class ActivityTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
