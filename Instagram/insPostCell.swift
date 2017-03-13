//
//  insPostCell.swift
//  Instagram
//
//  Created by Wenn Huang on 3/12/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import Parse

class insPostCell: UITableViewCell {


    @IBOutlet weak var postImageView : UIImageView!
    @IBOutlet weak var postCaptionLabel: UILabel!


    
    var post : PFObject! {
        didSet {
            
            postCaptionLabel.text = post["caption"] as! String
            
            let userImageFile = post["media"] as! PFFile
            userImageFile.getDataInBackground {
                (imageData, error)  in
                if !(error != nil) {
                    let image = UIImage(data:imageData!)
                    self.postImageView.image = image
                }
            }
            
       
            
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
