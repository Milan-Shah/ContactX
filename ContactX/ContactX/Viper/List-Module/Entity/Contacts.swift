//
//  Contacts.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/* //Sample JSON Response of a contact
 [{
     "name": "Miss Piggy",
     "id": "13",
     "companyName": "Muppets, Baby",
     "isFavorite": false,
     "smallImageURL": "https://s3.amazonaws.com/technical-challenge/v3/images/miss-piggy-small.jpg",
     "largeImageURL": "https://s3.amazonaws.com/technical-challenge/v3/images/miss-piggy-large.jpg",
     "emailAddress": "Miss.Piggy@muppetsbaby.com",
     "birthdate": "1987-05-11",
    "phone": {
         "work": "602-225-9543",
         "home": "602-225-9188",
         "mobile": ""
     },
     "address": {
         "street": "3530 E Washington St",
         "city": "Phoenix",
         "state": "AZ",
         "country": "US",
         "zipCode": "85034"
     }
 },...]
 */

class Contacts: Object, Decodable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var companyName: String = ""
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var smallImageURL: String = ""
    @objc dynamic var largeImageURL: String = ""
    @objc dynamic var emailAddress: String = ""
    @objc dynamic var birthdate: String = ""
    
    @objc dynamic var street: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var country: String = ""
    @objc dynamic var zipCode: String = ""
    
    @objc dynamic var work: String = ""
    @objc dynamic var home: String = ""
    @objc dynamic var mobile: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum ContactsCodingKeys: String, CodingKey {
        case name
        case id
        case companyName
        case isFavorite
        case smallImageURL
        case largeImageURL
        case emailAddress
        case birthdate
        case phone, work, home, mobile
        case address, street, city, state, country, zipCode
    }
    
    convenience init(_ name: String, _ id: String, _ companyName: String , _ isFavorite: Bool, _ smallImageURL: String, _ largeImageURL: String, _ emailAddress: String, _ birthdate: String, _ street: String, _ city: String, _ state: String, _ country: String,
        _ zipCode: String, _ work: String , _ home: String , _ mobile: String) {
        self.init()
        self.name = name
        self.id = id
        self.companyName = companyName
        self.isFavorite = isFavorite
        self.smallImageURL = smallImageURL
        self.largeImageURL = largeImageURL
        self.emailAddress = emailAddress
        self.birthdate = birthdate
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.zipCode = zipCode
        self.work = work
        self.home = home
        self.mobile = mobile

        
    }
    
    convenience required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ContactsCodingKeys.self)
        
        let name = try values.decode(String.self, forKey: .name)
        let id = try values.decode(String.self, forKey: .id)
        let companyName = try values.decodeIfPresent(String.self, forKey: .companyName) ?? ""
        let isFavorite = try values.decode(Bool.self, forKey: .isFavorite)
        let smallImageURL = try values.decode(String.self, forKey: .smallImageURL)
        let largeImageURL = try values.decode(String.self, forKey: .largeImageURL)
        let emailAddress = try values.decode(String.self, forKey: .emailAddress)
        let birthdate = try values.decode(String.self, forKey: .birthdate)

        // Address
        let address = try values.nestedContainer(keyedBy: ContactsCodingKeys.self, forKey: .address)
        let street = try address.decode(String.self, forKey: .street)
        let city = try address.decode(String.self, forKey: .city)
        let state = try address.decode(String.self, forKey: .state)
        let country = try address.decode(String.self, forKey: .country)
        let zipCode = try address.decode(String.self, forKey: .zipCode)
        
        // Phone
        let phone = try values.nestedContainer(keyedBy: ContactsCodingKeys.self, forKey: .phone)
        
        var work: String = ""
        if phone.contains(.work) {
            work = try phone.decode(String.self, forKey: .work)
        }
        
        var home: String = ""
        if phone.contains(.home) {
            home = try phone.decode(String.self, forKey: .home)
        }
        
        var mobile: String = ""
        if phone.contains(.mobile) {
            mobile = try phone.decode(String.self, forKey: .mobile)
        }
        
        self.init(name, id, companyName, isFavorite, smallImageURL, largeImageURL, emailAddress, birthdate, street, city, state, country, zipCode, work, home, mobile)
    }
    
    required init() {
        super.init()
    }
 
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
