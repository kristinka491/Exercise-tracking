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

    func setUpCell(_ exercise: WorkoutItemModel) {
        quantityOfIterationsLabel.text = "\(exercise.iterationsCount ?? 0)"
        dateLabel.text = dateFormatter(timestamp: exercise.timestamp)
    }

    private func dateFormatter(timestamp: Int?) -> String? {
        let calendar = Calendar.current

        if let timestamp = timestamp {
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

            if calendar.isDateInToday(date) {
                return "Today"
            } else if calendar.isDateInYesterday(date) {
                return "Yesterday"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"

                return dateFormatter.string(from: date)
            }
        }
        return nil
    }
}
