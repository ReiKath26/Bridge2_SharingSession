//
//  Item+CoreDataProperties.swift
//  ShoppingList_Bridge2Sharing
//
//  Created by Kathleen Febiola Susanto on 13/05/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var picture: Data?
    @NSManaged public var isBought: Bool
    @NSManaged public var market: Market?

}

extension Item : Identifiable {

}
