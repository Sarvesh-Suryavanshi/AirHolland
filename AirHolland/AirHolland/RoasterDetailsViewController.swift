//
//  RoasterDetailsViewController.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 14/10/21.
//

import UIKit

/// This view is responsible for showing roaster information details to the crew
class RoasterDetailsViewController: UIViewController {

    //MARK: - IBOutlets

    @IBOutlet weak var roasterImageView: UIImageView!
    @IBOutlet weak var departureImage: UIImageView!
    @IBOutlet weak var arrivalImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var moreInformationStackView: UIStackView!

    //MARK: - Properties

    private(set) var roaster: Roaster?
    
    //MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHeaderView()
    }
}

//MARK: - Functions

extension RoasterDetailsViewController {
    
    /// Injecting and configuring the view
    /// - Parameter roaster: roaster description
    func configure(with roaster: Roaster) {
        self.roaster = roaster
    }
    
    private func setupHeaderView() {
        if let roaster = roaster {
            self.titleLabel.text = roaster.displayTitle
            let subtitle: String = {
                switch roaster.dutyIdentifier {
                case .standby:
                    return roaster.displaySubtitle
                case .flight, .positioning:
                    arrivalImage.isHidden = false
                    departureImage.isHidden = false
                    return "Departure - \(roaster.timeOfDepart) | Arrival - \(roaster.timeOfArrive)"
                case .layover:
                    return roaster.timings
                case .dayOff:
                    return "You have a day off. Have Fun !!"
                case .none:
                    return ""
                }
            }()
            self.subtitleLabel.text = subtitle
            self.roasterImageView.image = UIImage(systemName: roaster.iconName)
        }
    }
}
