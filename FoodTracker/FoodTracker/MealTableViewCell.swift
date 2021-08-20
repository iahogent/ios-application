//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Cuenta de Iñigo on 18/8/21.
//  Copyright © 2021 Apple Inc. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var starRatingControl: RatingControl!
    @IBOutlet weak var euroRatingControl: RatingControl!
    @IBOutlet weak var forkRatingControl: RatingControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
