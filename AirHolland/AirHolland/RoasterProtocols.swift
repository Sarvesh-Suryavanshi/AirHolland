//
//  RoasterProtocols.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import Foundation

protocol RoasterViewProtocol: AnyObject {
    
    func loadRoaster()
    
    func updateUI()
}

protocol RoasterViewModelProtocol: AnyObject {
    
    func loadRoaster()
    
    func rows(in section: Int) -> Int
    
    var sections: Int { get }
    
    func roaster(at indexPath: IndexPath) -> Roaster?
    
    func sectionDisplayDate(section: Int) -> String?
}

protocol RoasterModelProtocol: AnyObject {
    
    func loadRoaster(onCompletion: @escaping ([RoasterDisplayData]?) -> Void)
}
