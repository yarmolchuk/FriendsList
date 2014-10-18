//
//  FriendTableViewCell.swift
//  FriendsList
//
//  Created by Yarmolchuk Dima on 18.10.14.
//  Copyright (c) 2014 Yarmolchuk Dima. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var phoneLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
