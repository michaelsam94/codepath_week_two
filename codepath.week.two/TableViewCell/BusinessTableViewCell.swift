//
//  BusinessTableViewCell.swift
//  codepath.week.two
//
//  Created by Michael on 13/07/2021.
//

import Foundation
import UIKit
import Cosmos

class BusinessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    
    @IBOutlet weak var bussinessRatingBar: CosmosView!
    
    @IBOutlet weak var businessReviewCountLabel: UILabel!
    
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var businessCategoriesLabel: UILabel!
    
    
    override func prepareForReuse() {
        businessImageView.image = nil
        businessImageView.cancelImageLoad()
    }
    
}
