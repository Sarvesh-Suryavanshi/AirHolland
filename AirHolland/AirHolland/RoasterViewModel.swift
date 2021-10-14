//
//  RoasterViewModel.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import Foundation

/// View Model responsible for holding business logic
class RoasterViewModel {
    
    //MARK: - Properties

    private var view: RoasterViewProtocol?
    private var model: RoasterModelProtocol?
    private var roasterdDisplayList: [RoasterDisplayData]?
    
    //MARK: - Initialization

    init(view: RoasterViewProtocol, model: RoasterModelProtocol) {
        self.view = view
        self.model = model
    }
}

//MARK: - Roaster ViewModel Protocol Methods
extension RoasterViewModel: RoasterViewModelProtocol {
    
    func roasterDisplayData(for section: Int) -> RoasterDisplayData? {
        guard
            let roasterdDisplayList = self.roasterdDisplayList,
            !roasterdDisplayList.isEmpty,
            roasterdDisplayList.indices.contains(section)
        else { return nil }
        let roasterDisplayData = roasterdDisplayList[section]
        return roasterDisplayData
    }
    
    func sectionDisplayDate(section: Int) -> String? {
        return self.roasterDisplayData(for: section)?.displayDate
    }
    
    var sections: Int {
        return roasterdDisplayList?.count ?? 0
    }
    
    func rows(in section: Int) -> Int {
        return self.roasterDisplayData(for: section)?.roasterList?.count ?? 0
    }
    
    func roaster(at indexPath: IndexPath) -> Roaster? {
        guard
            let roasterList = self.roasterDisplayData(for: indexPath.section)?.roasterList,
            roasterList.indices.contains(indexPath.row)
        else { return nil }
        return roasterList[indexPath.row]
    }
    
    func loadRoaster() {
        self.view?.startedLoadingRoasterDetails()
        self.model?.loadRoaster(onCompletion: { [weak self] (roasterdDisplayList) in
            guard let weakSelf = self else { return }
            weakSelf.roasterdDisplayList = roasterdDisplayList
            weakSelf.view?.updateUI()
        })
    }
}
