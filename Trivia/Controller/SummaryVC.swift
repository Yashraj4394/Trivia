//
//  SummaryVC.swift
//  Trivia
//
//  Created by YashraJ Gujar on 14/06/21.
//

import UIKit

class SummaryVC: UIViewController {

  //MARK:- OUTLETS
  @IBOutlet weak var summaryTableView : UITableView!
  @IBOutlet weak var userNameLabel: UILabel!
  
  //MARK:- PROPERTIES
  private let databaseRealm = DatabaseUpdates()
  var userID : String = ""
  
  var userDataViewModel : UserDataViewModel? {
    didSet {
      summaryTableView.reloadData()
    }
  }
  
  //MARK:- LIFECYLE
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Summary"
    configureTableView()
    getSummary()
  }
  
  //MARK:- CONFIGURE
  private func configureTableView(){
    summaryTableView.delegate = self
    summaryTableView.dataSource = self
    summaryTableView.rowHeight = 60
  }
  
  //MARK:- ACTIONS
  @IBAction func finishedTapped(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  @IBAction func historyTapped(_ sender: UIButton) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryVC") as? HistoryVC {
      navigationController?.showDetailViewController(vc, sender: nil)
    }
  }
  
  //MARK:- HELPERS
  private func getSummary(){
    databaseRealm.fetchUserData(userID: userID) { (data) in
      self.userDataViewModel = UserDataViewModel(data: data)
      self.userNameLabel.text = "Hello , \(data.userName)"
    }
  }
}


//MARK:- TABLE VIEW DATASOURCE
extension SummaryVC : UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
        return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
      }
      return cell
    }()
    guard let model = userDataViewModel else {return cell}
    if indexPath.row == 0 {
      cell.textLabel?.text = model.questionOne
      cell.detailTextLabel?.text = model.answerOne
    } else if indexPath.row == 1 {
      cell.textLabel?.text = model.questionTwo
      cell.detailTextLabel?.text = model.answerTwo
    }
    return cell
  }
}

//MARK:- TABLEVIEW DELEGATE
extension SummaryVC:UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}
