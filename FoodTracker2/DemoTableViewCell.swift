//
//  DemoTableViewCell.swift
//  FoodTracker2
//
//  Created by Khuất Dũng on 1/4/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
