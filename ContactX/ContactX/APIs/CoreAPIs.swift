//
//  CoreAPIs.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation

struct Base {
    static let route = "https://s3.amazonaws.com/technical-challenge/v3"
}

protocol CoreAPI {
    var path: String { get }
    var url: URL { get }
}

enum CoreAPIs {
    
    enum contacts: CoreAPI {
        
        case getContactslist
        internal var path: String {
            return "/contacts.json"
        }
        public var url: URL {
            return URL(string: String(format: "%@%@", Base.route, path))! // One of those places where we would want our app to crash if its nil so force wrapping with (!)
        }
    }
}
