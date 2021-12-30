//
//  AsteroidBottomCell.swift.swift
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 28/12/21.
//

import UIKit

class AsteroidBottomCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var neoReferenceIdTitleLbl: UILabel!
    @IBOutlet weak var neoReferenceIdLbl: UILabel!
    
    @IBOutlet weak var orbitIDLbl: UILabel!
    @IBOutlet weak var orbitIDTitleLbl: UILabel!
    
    @IBOutlet weak var kilometersPerHourTitleDistanceLbl: UILabel!
    @IBOutlet weak var kilometersPerHourDistanceLbl: UILabel!
    
    @IBOutlet weak var kilometersPerSecondTitleDistanceLbl: UILabel!
    @IBOutlet weak var kilometersPerSecondDistanceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

}
