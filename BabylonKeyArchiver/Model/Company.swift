//
//  Company.swift
//  BabylonKeyArchiver
//
//  Created by Bukalapak on 9/15/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import Foundation
import SwiftyJSON

class Company: NSObject, NSCoding, NSCopying {
    
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    override init() {
        
    }
    
    class func createFromJson(_ json: JSON) -> Company {
        let company = Company()
        company.name = json["name"].string
        company.catchPhrase = json["catchPhrase"].string
        company.bs = json["bs"].string
        return company
    }

    // MARK: - NSCoding
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String
        catchPhrase = aDecoder.decodeObject(forKey: "catchPhrase") as? String
        bs = aDecoder.decodeObject(forKey: "bs") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(catchPhrase, forKey: "catchPhrase")
        aCoder.encode(bs, forKey: "bs")
    }
    
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Company()
        copy.name = name
        copy.catchPhrase = catchPhrase
        copy.bs = bs
        return copy
    }
}
