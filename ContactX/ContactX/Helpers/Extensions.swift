//
//  Extensions.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation

extension Date {
    
    static func getFormattedDateString(dateString: String) -> String? {
    
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}

extension String {
    public func toPhoneNumber() -> String {
        let string = self.replacingOccurrences(of: "-", with: "")
        let formatted = string.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
        return formatted
    }
}
