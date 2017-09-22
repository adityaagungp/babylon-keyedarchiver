//
//  UserViewCell.swift
//  BabylonKeyArchiver
//
//  Created by Bukalapak on 9/15/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import UIKit

class UserViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var user: User? {
        didSet {
            if let user = user {
                nameLabel.text = user.name
                emailLabel.text = user.email
                if let address = user.address {
                    addressLabel.text = "\(address.street ?? "") \(address.suite ?? "")"
                    addressLabel.sizeToFit()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
