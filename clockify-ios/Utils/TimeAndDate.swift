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
    
    static func getDateFromString(date: String, time: String) -> Date? {
        let datetime = "\(date)-\(time)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy-hh:mm:ss"
        let date = dateFormatter.date(from: datetime)
        return date
    }
    
    static func getStartToEndString(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        let startResult = formatter.string(from: start)
        let endResult = formatter.string(from: end)
        return "\(startResult) - \(endResult)"
    }
    
    static func getStringfromDate(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yy"
        if(start==end){
            return formatter.string(from: start)
        } else {
            return formatter.string(from: end)
        }
    }
}
