//
//  Roaster.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import Foundation

struct Roaster: Codable {
    
    let flightNR: String
    let date: Date
    let aircraftType: String
    let tail: String
    let departure: String
    let destination: String
    let timeOfDepart: String
    let timeOfArrive: String
    let dutyID: Roaster.DutyID
    let dutyCode: String
    let captain: String
    let firstOfficer: String
    let flightAttendant: String
    
    var displayDate: String {
        let string = DateFormatter.ddMMMyy.string(from: self.date)
        return string
    }
    
    var displayTitle: String {
        switch self.dutyID {
        case .flight, .positioning:
            return "\(departure) - \(destination)"
        case .dayOff, .layover, .standby:
            return self.dutyCode
        }
    }
    
    var displaySubtitle: String {
        switch self.dutyID {
        case .flight, .positioning, .dayOff:
            return ""
        case .layover, .standby:
            return "\(departure) (\(destination))"
        }
    }
    
    var timings: String {
        switch self.dutyID {
        case .flight, .positioning:
            return "\(self.timeOfDepart) - \(self.timeOfArrive)"
        case .dayOff:
            return ""
        case .layover:
            return String.timeDifference(timeOfDepart: self.timeOfDepart, timeOfArrive: self.timeOfArrive)
        case .standby:
            return self.timeOfArrive
        }
    }
    var iconName: String {
        switch self.dutyID {
        case .flight:
            return "airplane"
        case .positioning:
            return "move.3d"
        case .dayOff:
            return "figure.wave"
        case .layover:
            return "suitcase.fill"
        case .standby:
            return "person.wave.2.fill"
        }
    }
}

private extension Roaster {
    
    private enum CodingKeys: String, CodingKey {
        case flightNR = "Flightnr"
        case date = "Date"
        case aircraftType = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case timeOfDepart = "Time_Depart"
        case timeOfArrive = "Time_Arrive"
        case dutyID = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case firstOfficer = "First Officer"
        case flightAttendant = "Flight Attendant"
    }
}

extension Roaster {
    
    enum DutyID: String, Codable {
        case dayOff = "DO"
        case standby = "SBY"
        case positioning = "POS"
        case flight = "FLT"
        case layover = "OFD"
    }
}
