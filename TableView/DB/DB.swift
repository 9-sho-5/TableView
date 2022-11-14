//
//  DB.swift
//  TableView
//
//  Created by Kusunose Hosho on 2022/11/14.
//

import Foundation
import RealmSwift

class Animal: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var createdDate: Date!
}

class DBList: Object {
    let animalList = List<Animal>()
}
