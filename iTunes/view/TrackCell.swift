//
//  TrackCell.swift
//  iTunes
//
//  Created by Paramjeet on 26/04/23.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var artworkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
