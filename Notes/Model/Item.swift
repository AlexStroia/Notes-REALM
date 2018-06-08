//
//  Item.swift
//  Notes
//
//  Created by Alex Stroia on 6/8/18.
//  Copyright © 2018 Alex Stroia. All rights reserved.
//

import Foundation
import RealmSwift

//MARK - parent category is a type linking objects which means that parent category has a relationship with an object of type Note, witch has a property called items(an array). Each item has a parent category which is of type note and comes from property items
class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var date: String = ""
    var parentCategory = LinkingObjects(fromType: Note.self, property: "items")
}
