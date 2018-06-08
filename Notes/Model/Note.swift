//
//  Note.swift
//  Notes
//
//  Created by Alex Stroia on 6/8/18.
//  Copyright © 2018 Alex Stroia. All rights reserved.
//

import Foundation
import RealmSwift

//MARK - Variables are marked with dynamic because this keyword allow this variable to auto-update themself. Also we have to use objc because this keyword comes from OBJECTIVE C API. REALM will monitor for changes of these variables. Every note has a name and a registration date. A note can have more items. Exemple: Go to shopping -> Buy Eggs, buy oats etc. this is a ONE TO MANY relationship
class Note: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var registredDate: String = ""
    let items = List<Item>()
}
