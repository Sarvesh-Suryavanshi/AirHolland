//
//  Roaster.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import CoreData

@objc(Roaster)
class Roaster: NSManagedObject, Codable {
    
    //MARK: - Managed Properties
    
    // CoreData and Codable Properties
    
    @NSManaged var flightNR: String
    @NSManaged var date: Date
    @NSManaged var aircraftType: String
    @NSManaged var tail: String
    @NSManaged var departure: String
    @NSManaged var destination: String
    @NSManaged var timeOfDepart: String
    @NSManaged var timeOfArrive: String
    @NSManaged var dutyID: String
    @NSManaged var dutyCode: String
    @NSManaged var captain: String
    @NSManaged var firstOfficer: String
    @NSManaged var flightAttendant: String
    
    //MARK: - Properties

    var displayDate: String {
        let string = DateFormatter.ddMMMyy.string(from: self.date)
        return string
    }
    
    var displayTitle: String {
        guard let dutyID = self.dutyIdentifier else { return "" }
        switch dutyID {
        case .flight, .positioning:
            return "\(departure) - \(destination)"
        case .dayOff, .layover, .standby:
            return self.dutyCode
        }
    }
    
    var displaySubtitle: String {
        guard let dutyID = self.dutyIdentifier else { return "" }
        switch dutyID {
        case .flight, .positioning, .dayOff:
            return ""
        case .layover, .standby:
            return "\(departure) (\(destination))"
        }
    }
    
    var timings: String {
        guard let dutyID = self.dutyIdentifier else { return "" }
        switch dutyID {
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
        guard let dutyID = self.dutyIdentifier else { return "" }
        switch dutyID {
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
    
    /// Created computed property for Duty enum as CoreData cannot store enum and structs
    var dutyIdentifier: Roaster.DutyID? {
        let dutyIdentifier = Roaster.DutyID(rawValue: self.dutyID)
        return dutyIdentifier
    }
    
    //MARK: - Initializers
    
    /// Decoder
    required convenience init(from decoder: Decoder) throws {
       guard
        let moc = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext,
        let entityDescriptor = NSEntityDescription.entity(forEntityName: "Roaster", in: moc)
        else {fatalError(" OMG !!") }
        
        self.init(entity: entityDescriptor, insertInto: moc)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.flightNR = try container.decodeIfPresent(String.self, forKey: .flightNR)!
        self.date = try container.decodeIfPresent(Date.self, forKey: .date)!
        self.aircraftType = try container.decodeIfPresent(String.self, forKey: .aircraftType)!
        self.tail = try container.decodeIfPresent(String.self, forKey: .tail)!
        self.departure = try container.decodeIfPresent(String.self, forKey: .departure)!
        self.destination = try container.decodeIfPresent(String.self, forKey: .destination)!
        self.timeOfArrive = try container.decodeIfPresent(String.self, forKey: .timeOfArrive)!
        self.timeOfDepart = try container.decodeIfPresent(String.self, forKey: .timeOfDepart)!
        self.dutyID = try container.decodeIfPresent(String.self, forKey: .dutyID)!
        self.dutyCode = try container.decodeIfPresent(String.self, forKey: .dutyCode)!
        self.captain = try container.decodeIfPresent(String.self, forKey: .captain)!
        self.firstOfficer = try container.decodeIfPresent(String.self, forKey: .firstOfficer)!
        self.flightAttendant = try container.decodeIfPresent(String.self, forKey: .flightAttendant)!
    }
    
    
    /// Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.flightNR, forKey: .flightNR)
        try container.encodeIfPresent(self.date, forKey: .date)
        try container.encodeIfPresent(self.aircraftType, forKey: .aircraftType)
        try container.encodeIfPresent(self.tail, forKey: .tail)
        try container.encodeIfPresent(self.departure, forKey: .departure)
        try container.encodeIfPresent(self.destination, forKey: .destination)
        try container.encodeIfPresent(self.timeOfArrive, forKey: .timeOfArrive)
        try container.encodeIfPresent(self.timeOfDepart, forKey: .timeOfDepart)
        try container.encodeIfPresent(self.dutyID, forKey: .dutyID)
        try container.encodeIfPresent(self.dutyCode, forKey: .dutyCode)
        try container.encodeIfPresent(self.captain, forKey: .captain)
        try container.encodeIfPresent(self.firstOfficer, forKey: .firstOfficer)
        try container.encodeIfPresent(self.flightAttendant, forKey: .flightAttendant)
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
