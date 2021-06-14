//
//  HistoryTableViewCell.swift
//  Trivia
//
//  Created by YashraJ Gujar on 15/06/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

  //MARK:- OUTLETS
  @IBOutlet weak var gameNumberLabel: UILabel!
  @IBOutlet weak var timeStampLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var questionOneLabel: UILabel!
  @IBOutlet weak var answerOneLabel: UILabel!
  @IBOutlet weak var questionTwoLabel: UILabel!
  @IBOutlet weak var answerTwoLabel: UILabel!
  
  //MARK:- LIFECYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
