//
//  Cars+CoreDataProperties.swift
//  CarsList
//
//  Created by Андрей Касутин on 19/05/2019.
//  Copyright © 2019 Андрей Касутин. All rights reserved.
//
//

import Foundation
import CoreData


extension Cars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cars> {
        return NSFetchRequest<Cars>(entityName: "Cars")
    }

    @NSManaged public var klass: String?
    @NSManaged public var model: String?
    @NSManaged public var producer: String?
    @NSManaged public var type: String?
    @NSManaged public var year: Int16

}
