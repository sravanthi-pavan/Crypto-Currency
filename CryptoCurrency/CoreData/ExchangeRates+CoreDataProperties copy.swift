//
//  ExchangeRates+CoreDataProperties.swift
//  
//
//  Created by Sravanthi Gumma on 10/31/21.
//
//

import Foundation
import CoreData


extension ExchangeRates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRates> {
        return NSFetchRequest<ExchangeRates>(entityName: "ExchangeRates")
    }

    @NSManaged public var date: String?
    @NSManaged public var code: String?
    @NSManaged public var rate: Double

}

