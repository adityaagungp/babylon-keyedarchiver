//
//  User.swift
//  BabylonKeyArchiver
//
//  Created by Bukalapak on 9/15/17.
//  Copyright © 2017 Bukalapak. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject, NSCoding, NSCopying {
    
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
    var phone: String?
    var website: String?
    var company: Company?
    
    override init() {
        
    }
    
    class func createFromJson(_ json: JSON) -> User {
        let user = User()
        user.id = json["id"].int
        user.name = json["name"].string
        user.username = json["username"].string
        user.email = json["email"].string
        user.address = Address.createFromJson(json["address"])
        user.phone = json["phone"].string
        user.website = json["website"].string
        user.company = Company.createFromJson(json["company"])
        return user
    }

    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        address = aDecoder.decodeObject(forKey: "address") as? Address
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        website = aDecoder.decodeObject(forKey: "website") as? String
        company = aDecoder.decodeObject(forKey: "company") as? Company
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(website, forKey: "website")
        aCoder.encode(company, forKey: "company")
    }
    
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = User()
        copy.id = id
        copy.name = name
        copy.username = username
        copy.email = email
        copy.address = address?.copy(with: zone) as? Address
        copy.phone = phone
        copy.website = website
        copy.company = company?.copy(with: zone) as? Company
        return copy
    }
}

