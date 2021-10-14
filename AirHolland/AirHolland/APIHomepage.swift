//
//  APIHomepage.swift
//  Newsroom
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import Foundation

/// Enum representing web services
enum API {
    
    case fetchRoaster
    
    var rawValue: URLRequest? {
        switch(self) {
        case .fetchRoaster:
            guard let apiURL = self.fetchRoaster else { return nil }
            return URLRequest(url: apiURL)
        }
    }
}

extension API {
    
    /// Configures base url component
    private var baseURLComponent: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rosterbuster.aero"
        return components
    }
    
    /// Provides Roaster Api url
    private var fetchRoaster: URL? {
        var component = self.baseURLComponent
        component.path = "/wp-content/uploads/dummy-response.json"
        return component.url
    }
}
