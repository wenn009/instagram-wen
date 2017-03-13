//
//  captionViewController.swift
//  Instagram
//
//  Created by Wenn Huang on 3/12/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import Parse

class captionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var postDescriptionTextField: UITextField!
    @IBOutlet weak var submitPostButton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!

    var picture : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
        // Do any additional setup after loading the view.
    }
    
    private func clear(){
        postDescriptionTextField.text = ""
        postDescriptionTextField.isEnabled = false
        submitPostButton.isEnabled = false
        postImageView.image = nil
        createButton.isEnabled = true
        createButton.alpha = 1
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func showAlert(title: String, message: String)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) {_ in /*Some Code to Execute*/}
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func toAlbum(_ sender: UIButton) {
        
        
        
        func showCamera(){
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            self.present(cameraPicker, animated: true, completion: nil)
            print("using camera")
        }
        
        func showAlbum(){
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .photoLibrary
            self.present(cameraPicker, animated: true, completion: nil)
            print ("using album")
        }
        
            let action = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
            action.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
                showCamera()
            }))
            action.addAction(UIAlertAction(title: "Album", style: .default, handler: { (UIAlertAction) in
                showAlbum()
            }))
            self.present(action, animated: true, completion: nil)
            
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picture = image
        postImageView.image = picture
        postDescriptionTextField.isEnabled = true
        submitPostButton.isEnabled = true
        createButton.isEnabled = false
        createButton.alpha = 0
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSaveButton(_ sender: Any) {
        
        let resizedImage = self.resize(image: postImageView.image!, newSize: CGSize(width: 400, height: 400))
        
        Post.postUserImage(image: resizedImage, withCaption: postDescriptionTextField.text) { (success, error) in
            if success
            {
                self.showAlert(title: "Success", message: "Image Posted")
                self.clear()
            }
            else
            {
                self.showAlert(title: "Error", message: (error?.localizedDescription)!)
            }

        }
        
        
    }
    

    
    

    private func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x:0,y:0,width:newSize.width,height:newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
