//
//  TimeAndDate.swift
//  clockify-ios
//
//  Created by Roberto Kreshna on 11/10/23.
//

import Foundation

class TimeAndDate {
    static func getcurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yy"
        let result = formatter.string(from: date)
        return result
    }
    
    static func getcurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
    static func getDateFromString(date: String, time: String) -> Date?{
        let datetime = "\(date)-\(time)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy-hh:mm:ss"
        let date = dateFormatter.date(from: datetime)
        return date
    }
}
