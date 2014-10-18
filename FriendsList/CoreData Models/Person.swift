//
//  Person.swift
//  FriendsList
//
//  Created by Yarmolchuk Dima on 18.10.14.
//  Copyright (c) 2014 Yarmolchuk Dima. All rights reserved.
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var phone: String

}
