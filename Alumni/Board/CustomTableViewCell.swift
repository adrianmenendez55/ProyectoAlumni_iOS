//
//  CustomTableViewCell.swift
//  Alumni
//
//  Created by alumnos on 29/1/18.
//  Copyright © 2018 adrian. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var eventLbl: UILabel!
    @IBOutlet weak var titleEventLbl: UILabel!
    @IBOutlet weak var informationEventLbl: UITextView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var imageEventView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
