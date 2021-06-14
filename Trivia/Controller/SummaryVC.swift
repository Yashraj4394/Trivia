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
  var userData : UserData?{
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
      navigationController?.show(vc, sender: nil)
    }
  }
  
  //MARK:- HELPERS
  private func getSummary(){
    databaseRealm.fetchUserData(userID: userID) { (data) in
      self.userData = data
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
    
    guard let data = self.userData else {return cell}
    if indexPath.row == 0 {
      cell.textLabel?.text = data.questionOne
      cell.detailTextLabel?.text = data.answersOne.first?.answer ?? ""
    } else if indexPath.row == 1 {
      cell.textLabel?.text = data.questionTwo
      let asd = Array(data.answersTwo).map({ $0.answer })
        cell.detailTextLabel?.text = asd.joined(separator: ",")
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
