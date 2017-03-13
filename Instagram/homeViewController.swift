//
//  homeViewController.swift
//  Instagram
//
//  Created by Wenn Huang on 3/9/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import Parse

class homeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var posts: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            tableView.delegate = self
            tableView.dataSource = self
        // Do any additional setup after loading the view.
            fetchPost()
    }
    private func fetchPost(){
        User.fetchPosts(sucess: { (object: [PFObject]?) -> () in
            
            self.posts = object
            self.tableView.reloadData()
            
        }) { (error: NSError?) -> () in
            
            print("Unable to retrieve data")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "insPostCell", for: indexPath) as! insPostCell
        cell.post = posts![indexPath.section]
        
        return cell
    }
    
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let posts = posts {
            return posts.count
        }
        else {
            return 0;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    @IBAction func onLogOutAction(_ sender: UIBarButtonItem) {
        PFUser.logOutInBackground { (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Logged out successfully")
            }
        }
        let userDidlogoutNotificationName = NSNotification.Name(rawValue: "UserDidLogout")
        NotificationCenter.default.post(name: userDidlogoutNotificationName, object: nil)
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
