//
//  QuestionTwoVC.swift
//  Trivia
//
//  Created by YashraJ Gujar on 14/06/21.
//

import UIKit

class QuestionTwoVC: UIViewController {
  
  //MARK:- OUTLETS
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var optionsTableView: UITableView!
  
  //MARK:- PROPERTIES
  private let options = ["A) White","B) Yellow","C) Orange","D) Green"]
  var userID : String = ""
  private let databaseRealm = DatabaseUpdates()
  
  //MARK:- LIFECYLE
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureTableView()
  }
  
  //MARK:- CONFIGURE
  private func configureTableView(){
    optionsTableView.delegate = self
    optionsTableView.dataSource = self
    optionsTableView.rowHeight = 60
    optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  //MARK:- ACTIONS
  @IBAction func nextTapped(_ sender: UIButton) {
    guard let selectedRows = optionsTableView.indexPathsForSelectedRows else {
      showAlert("Please choose your answer")
      return
    }
    //      print(selectedRows)
    var answers = [Answers]()
    for x in selectedRows {
      print(options[x.row])
      answers.append(Answers(answer: options[x.row]))
    }
    updateDB(answers: answers)
    if let vc = storyboard?.instantiateViewController(withIdentifier: "SummaryVC") as? SummaryVC {
      vc.userID = userID
      navigationController?.show(vc, sender: nil)
    }
  }
  
  //MARK:- HELPERS
  private func updateDB(answers : [Answers]){
    databaseRealm.updateQuestionTwo(userID: userID, answer: answers, question: questionLabel.text ?? "")
  }
}

//MARK:- TABLE VIEW DATASOURCE
extension QuestionTwoVC : UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = options[indexPath.row]
    cell.selectionStyle = .none
    return cell
  }
}

//MARK:- TABLEVIEW DELEGATE
extension QuestionTwoVC:UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.accessoryType = .checkmark
    }
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      if cell.accessoryType == .checkmark {
        cell.accessoryType = .none
      }
    }
  }
}

//MARK:-
extension QuestionTwoVC{
  
}
