//
//  Market+CoreDataProperties.swift
//  ShoppingList_Bridge2Sharing
//
//  Created by Kathleen Febiola Susanto on 13/05/22.
//
//

import Foundation
import CoreData


extension Market {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Market> {
        return NSFetchRequest<Market>(entityName: "Market")
    }

    @NSManaged public var distance: Double
    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?
    
    public var itemArray: [Item]
    {
        get
        {
            return items?.allObjects as! [Item]
        }
    }

}

// MARK: Generated accessors for items
extension Market {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Market : Identifiable {

}
