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
        formatter.dateFormat = "HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
    static func displayDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yy"
        let result = formatter.string(from: date)
        return result
    }
    
    static func displayTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let result = formatter.string(from: date)
        return result
    }
    
    static func getDateFromStringToCompare(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        let date = dateFormatter.date(from: date)
        return date
    }
    
    static func getDateFromString(date: String, time: String) -> Date? {
        let datetime = "\(date)-\(time)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy-HH:mm:ss"
        let date = dateFormatter.date(from: datetime)
        return date
    }
    
    static func getStartToEndString(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
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
    
    static func getHourFromDuration(duration: String) -> String {
        let index = duration.firstIndex(of: ":")!
        let res = String(duration[..<index])
        return res
    }
    
    static func getMinuteFromDuration(duration: String) -> String {
        let firstIndex = duration.index(duration.firstIndex(of: ":")!, offsetBy: 1)
        let lastIndex = duration.lastIndex(of: ":")!
        let res = String(duration[firstIndex..<lastIndex])
        return res
    }
    
    static func getSecondFromDuration(duration: String) -> String {
        let index = duration.index(duration.lastIndex(of: ":")!, offsetBy: 1)
        let res = String(duration[index...])
        return res
    }
}
