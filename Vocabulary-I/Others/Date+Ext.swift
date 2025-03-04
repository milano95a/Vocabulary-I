//
//  Date+Ext.swift
//  Vocabulary-I
//
//  Created by Jamoliddinov Abduraxmon on 17/01/25.
//

import Foundation

extension Date {
    static var endOfToday: Date {
        if let endOfToday = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: .now) {
            return endOfToday
        } else {
            return .now
        }
    }
    
    static var beginningOfToday: Date {
        if let endOfToday = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: .now) {
            return endOfToday
        } else {
            return .now
        }
    }
    
    static var oneYearBefore: Date {
        return .now.addingTimeInterval(-367 * 86400)
    }
}
