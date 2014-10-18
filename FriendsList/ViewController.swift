//
//  ViewController.swift
//  FriendsList
//
//  Created by Yarmolchuk Dima on 18.10.14.
//  Copyright (c) 2014 Yarmolchuk Dima. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var addFriendBtn: UIBarButtonItem!
    
    var friends = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\"The List Friends\""
        
        friendsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Person")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            friends = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCellIdentifier") as FriendTableViewCell
        
        let person = friends[indexPath.row]
        
        cell.nameLab!.text = person.valueForKey("name") as String?
        cell.phoneLab!.text = person.valueForKey("phone") as String?
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        self.friendsTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let person = friends[indexPath.row]
        let showMessage:String = NSString(format:"%@ %@", person.valueForKey("name") as String!, person.valueForKey("phone") as String!) as String
        
        var alert = UIAlertController(title: "Friend", message: showMessage, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok.", style: .Default) {
            (action: UIAlertAction!) -> Void in
        }
        
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
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
                
            let nameFriendField = alert.textFields![0] as UITextField
            let phoneFrienfField = alert.textFields![1] as UITextField
            
            self.saveName(nameFriendField.text, phone:phoneFrienfField.text)
            self.friendsTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (nameFriendField: UITextField!) -> Void in
            
            nameFriendField.placeholder = "Name friend"
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (phoneFrienfField: UITextField!) -> Void in
            
            phoneFrienfField.placeholder = "Phone friend"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func saveName(name: String, phone: String) {

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        person.setValue(name, forKey: "name")
        person.setValue(phone, forKey: "phone")
        
        var error: NSError?
        
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        
        friends.append(person)
    }
}

