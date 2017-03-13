//
//  Post.swift
//  Instagram
//
//  Created by Wenn Huang on 3/12/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import Parse


class Post: NSObject {
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?)
    {
        let post = PFObject(className: "Post")
        
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
       // post["likesCount"] = 0
       // post["commentsCount"] = 0
        
        let timeStamp = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
        post["timeStamp"] = formatter.string(from: timeStamp as Date)
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
