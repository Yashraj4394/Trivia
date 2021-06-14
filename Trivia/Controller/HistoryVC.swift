//
//  HistoryVC.swift
//  Trivia
//
//  Created by YashraJ Gujar on 14/06/21.
//

import UIKit
import RealmSwift

class HistoryVC: UIViewController {
  
  //MARK:- OUTLETS
  @IBOutlet weak var historyTableView : UITableView!
  
  //MARK:- PROPERTIES
  var userData : [UserData]? {
    didSet {
      historyTableView.reloadData()
    }
  }
  private let databaseRealm = DatabaseUpdates()
  
  //MARK:- LIFECYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    fetchUsersData()
  }
  
  //MARK:- CONFIGURE
  private func configureTableView(){
    historyTableView.delegate = self
    historyTableView.dataSource = self
    historyTableView.rowHeight = UITableView.automaticDimension
    historyTableView.estimatedRowHeight = 150
  }
  
  //MARK:- HELPERS
  private func fetchUsersData(){
    databaseRealm.fetchAllData { (data) in
      self.userData = data
    }
  }
  
  func getDate(time:Double)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
    dateFormatter.timeZone = .current
    let date = Date(timeIntervalSince1970: time)
    let localDate = dateFormatter.string(from: date)
    return localDate
  }
}

//MARK:- TABLE VIEW DATASOURCE
extension HistoryVC : UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
    if let userData = self.userData {
      let data = userData[indexPath.row]
      cell.userNameLabel.text = "Name : \(data.userName)"
      cell.gameNumberLabel.text = "Game: \(data.gameNumber)"
      cell.timeStampLabel.text = getDate(time: data.timestamp)
      cell.questionOneLabel.text = data.questionOne
      cell.questionTwoLabel.text = data.questionTwo
      let answerOneArray = Array(data.answersOne).map({ $0.answer })
      cell.answerOneLabel.text = answerOneArray.joined()
      let answerTwoArray = Array(data.answersTwo).map({ $0.answer })
      cell.answerTwoLabel.text = answerTwoArray.joined(separator: ",")
    }
    return cell
  }
}

//MARK:- TABLEVIEW DELEGATE
extension HistoryVC:UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
