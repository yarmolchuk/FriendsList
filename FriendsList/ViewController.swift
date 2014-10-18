//
//  ViewController.swift
//  FriendsList
//
//  Created by Yarmolchuk Dima on 18.10.14.
//  Copyright (c) 2014 Yarmolchuk Dima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var addFriendBtn: UIBarButtonItem!
    
    var friends = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\"The List Friends\""
        
        friendsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
            
        cell.textLabel!.text = friends[indexPath.row]
            
        return cell
    }
    
    // MARK: Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Action
    @IBAction func actAddFriend(sender: AnyObject) {
        
        var alert = UIAlertController(title: "New friend", message: "Add a new friend", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) {
            (action: UIAlertAction!) -> Void in
                
            let textField = alert.textFields![0] as UITextField
            
            self.friends.append(textField.text)
            self.friendsTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

