//
//  CustomUserListTableViewCell.swift
//  Alumni
//
//  Created by alumnos on 1/2/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class CustomUserListTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameUserLbl: UILabel!
    @IBOutlet weak var classUserLbl: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
