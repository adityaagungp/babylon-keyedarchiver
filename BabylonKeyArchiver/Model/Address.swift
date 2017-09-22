//
//  Address.swift
//  BabylonKeyArchiver
//
//  Created by Bukalapak on 9/15/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import Foundation
import SwiftyJSON

class Address: NSObject, NSCoding, NSCopying {
    
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: Geo?
    
    override init() {
        
    }
    
    class func createFromJson(_ json: JSON) -> Address {
        let address = Address()
        address.street = json["street"].string
        address.suite = json["suite"].string
        address.city = json["city"].string
        address.zipcode = json["zipcode"].string
        address.geo = Geo.createFromJson(json["geo"])
        return address
    }

    // MARK: - NSCoding
    required init?(coder aDecoder: NSCoder) {
        street = aDecoder.decodeObject(forKey: "street") as? String
        suite = aDecoder.decodeObject(forKey: "suite") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        zipcode = aDecoder.decodeObject(forKey: "zipcode") as? String
        geo = aDecoder.decodeObject(forKey: "geo") as? Geo
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(street, forKey: "street")
        aCoder.encode(suite, forKey: "suite")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(zipcode, forKey: "zipcode")
        aCoder.encode(geo, forKey: "geo")
    }
    
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Address()
        copy.street = street
        copy.suite = suite
        copy.city = city
        copy.zipcode = zipcode
        copy.geo = geo?.copy(with: zone) as? Geo
        return copy
    }
}
