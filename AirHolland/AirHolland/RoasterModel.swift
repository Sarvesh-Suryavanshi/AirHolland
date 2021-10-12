//
//  RoasterModel.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import Foundation

class RoasterModel {
}

extension RoasterModel: RoasterModelProtocol {
    
    func loadRoaster(onCompletion: @escaping ([RoasterDisplayData]?) -> Void) {
        Network.loadAndParse(request: API.fetchRoaster.rawValue, outputType: [Roaster].self) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let roasterList):
                let roasterDisplayList = weakSelf.process(roasterList: roasterList)
                onCompletion(roasterDisplayList)
                print(roasterList)
            case .failure(let error):
                onCompletion(nil)
                print(error)
            }
        }
    }
    
    private func process(roasterList: [Roaster]) -> [RoasterDisplayData]? {
        if !roasterList.isEmpty {
            var dateSet = Set<Date>()
            roasterList.forEach { roaster in dateSet.update(with: roaster.date) }
            var roasterdDisplayList: [RoasterDisplayData] = []
            dateSet.forEach { date in
                let roastersForDate = roasterList.filter({ roaster in
                    return roaster.date == date
                })
                let roasterDisplayData = RoasterDisplayData(date: date, roasterList: roastersForDate)
                roasterdDisplayList.append(roasterDisplayData)
                
                roasterdDisplayList = roasterdDisplayList.sorted { currentItem, nextItem in
                    return currentItem.date < nextItem.date
                }
            }
            return roasterdDisplayList
        }
        return nil
    }
}

struct RoasterDisplayData {
    let date: Date
    let roasterList: [Roaster]?
    
    var displayDate: String {
        let string = DateFormatter.ddMMMyy.string(from: self.date)
        return string
    }
}
