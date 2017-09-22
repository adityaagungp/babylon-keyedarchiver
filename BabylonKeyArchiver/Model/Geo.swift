//
//  Geo.swift
//  BabylonKeyArchiver
//
//  Created by Bukalapak on 9/15/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import Foundation
import SwiftyJSON

class Geo: NSObject, NSCoding, NSCopying {
    
    var lat: Double?
    var lng: Double?
    
    override init() {
        
    }
    
    class func createFromJson(_ json: JSON) -> Geo {
        let geo = Geo()
        geo.lat = json["lat"].double
        geo.lng = json["lng"].double
        return geo
    }

    // MARK: - NSCoding
    required init?(coder aDecoder: NSCoder) {
        lat = aDecoder.decodeObject(forKey: "lat") as? Double
        lng = aDecoder.decodeObject(forKey: "lng") as? Double
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
    }
    
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Geo()
        copy.lat = lat
        copy.lng = lng
        return copy
    }
}
