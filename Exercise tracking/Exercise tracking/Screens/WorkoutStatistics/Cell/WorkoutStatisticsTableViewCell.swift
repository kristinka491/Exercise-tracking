//
//  WorkoutStatisticsTableViewCell.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 17.10.2022.
//

import UIKit

class WorkoutStatisticsTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quantityOfIterationsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpCell() {
        
    }

    
}
