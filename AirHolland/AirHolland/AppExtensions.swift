//
//  AppExtensions.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import UIKit


extension UIViewController {
    
    class var name: String {
        return String(describing: self)
    }
}

extension DateFormatter {
    
    static var ddMMyy: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }
    
    static var HHmm : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
    
    static var ddMMMyy : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
}

extension String {
    
    static func timeDifference(timeOfDepart: String, timeOfArrive: String) -> String {
        let dateFormat = DateFormatter.HHmm
        guard
            let departDateTime = dateFormat.date(from: timeOfDepart),
            let arriveDateTime = dateFormat.date(from: timeOfArrive)
        else { return "" }
        let timeInterval = arriveDateTime.timeIntervalSince(departDateTime)
        return timeInterval.displayTime
    }
}

extension TimeInterval {
    
    var displayTime: String {
        guard self > 0 && self < Double.infinity else { return "" }
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d hours", hours, minutes)
    }
}
