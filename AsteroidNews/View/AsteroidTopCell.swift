//
//  AsteroidTopCell
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 27/12/21.
//

import UIKit

class AsteroidTopCell: UITableViewCell {

    @IBOutlet weak var orbitingBodyLbl: UILabel!
    @IBOutlet weak var orbitingBodyTitleLbl: UILabel!
    
    @IBOutlet weak var hazardousLbl: UILabel!
    @IBOutlet weak var hazardousTitleLbl: UILabel!

    @IBOutlet weak var firstObservationLbl: UILabel!
    @IBOutlet weak var firstObservationTitleLbl: UILabel!

    @IBOutlet weak var lastObservationLbl: UILabel!
    @IBOutlet weak var lastObservationTitleLbl: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
}
