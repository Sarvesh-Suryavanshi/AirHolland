//
//  DashboardBuilder.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import UIKit

class DashboardBuilder {
    
    /// Builder method to create instance of RoasterViewController
    /// - Returns: returns RoasterViewController
    class func buildRoasterView() -> RoasterViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: RoasterViewController.name) as? RoasterViewController
        else { return nil }
        
        let model = RoasterModel()
        let viewModel = RoasterViewModel(view: view, model: model)
        view.viewModel = viewModel
        return view
    }
}
