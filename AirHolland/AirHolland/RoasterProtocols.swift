//
//  RoasterProtocols.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import Foundation


/// Roaster View Protocol
protocol RoasterViewProtocol: AnyObject {
    
    /// Fetch roaster details
    func loadRoaster()
    
    /// Notifies view to update UI once service call is done
    func updateUI()
    
    /// Notifies view to start loading indicator
    func startedLoadingRoasterDetails()
}

/// Roaster View  Model Protocol
protocol RoasterViewModelProtocol: AnyObject {
    
    /// Fetch roaster details
    func loadRoaster()
    
    /// Returns row count for provided section index
    /// - Returns: Row count
    func rows(in section: Int) -> Int
    
    /// Returns section count
    var sections: Int { get }
    
    /// Returns roaster entity for provided indexPath
    /// - Returns: optional Roaster entity
    func roaster(at indexPath: IndexPath) -> Roaster?
    
    /// Returns section title for provided section index
    /// - Returns: Section Title
    func sectionDisplayDate(section: Int) -> String?
}

/// Roaster  Model Protocol
protocol RoasterModelProtocol: AnyObject {
    
    /// Fetch roaster details
    func loadRoaster(onCompletion: @escaping ([RoasterDisplayData]?) -> Void)
}
