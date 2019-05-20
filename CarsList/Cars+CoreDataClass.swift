//
//  Cars+CoreDataClass.swift
//  CarsList
//
//  Created by Андрей Касутин on 19/05/2019.
//  Copyright © 2019 Андрей Касутин. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Cars)

public class Cars: NSManagedObject {
    convenience init() {
        let entity = NSEntityDescription.entity(forEntityName: "Cars", in: AppDelegate.instance.persistentContainer.viewContext)!
        self.init(entity: entity, insertInto: AppDelegate.instance.persistentContainer.viewContext)
    }
}
