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
  var userDataViewModel : [UserDataViewModel]? {
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
      self.userDataViewModel = data
    }
  }
}

//MARK:- TABLE VIEW DATASOURCE
extension HistoryVC : UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userDataViewModel?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
    if let vm = self.userDataViewModel {
      cell.setData(vm[indexPath.row])
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
