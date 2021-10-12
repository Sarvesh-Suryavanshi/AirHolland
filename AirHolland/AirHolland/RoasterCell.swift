//
//  RoasterCell.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 12/10/21.
//

import UIKit

class RoasterCell: UITableViewCell {
    
    
    @IBOutlet weak var roasterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var aircraftTypeLabel: UILabel!
    
    @IBOutlet weak var firstOfficerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let reuseIdentifier = "RoasterCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {
        self.roasterImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.flightNumberLabel.text = nil
        self.aircraftTypeLabel.text = nil
        self.firstOfficerLabel.text = nil
        self.timeLabel.text = nil
    }
    
    func configure(with roaster: Roaster) {
        self.titleLabel.text = roaster.displayTitle
        self.subtitleLabel.text = roaster.displaySubtitle
        self.timeLabel.text = roaster.timings
        self.firstOfficerLabel.text = roaster.captain
        self.roasterImageView.image = UIImage(systemName: roaster.iconName)
        self.flightNumberLabel.text = roaster.flightNR
        self.aircraftTypeLabel.text = roaster.aircraftType
    }
}


