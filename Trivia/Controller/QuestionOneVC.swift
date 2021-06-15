//
//  QuestionOneVC.swift
//  Trivia
//
//  Created by YashraJ Gujar on 14/06/21.
//

import UIKit
import RealmSwift

class QuestionOneVC: UIViewController {
  
  //MARK:- OUTLETS
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var optionsTableView: UITableView!
  
  //MARK:- PROPERTIES
  private var selectedRow : Int = 0
  var userID : String = ""
  private let databaseRealm = DatabaseUpdates()
  private let questions = QuestionBank()
  
  //MARK:- LIFECYLE
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    navigationItem.setHidesBackButton(true, animated: true)
    questionLabel.text = questions.list.first?.question
  }
  
  //MARK:- CONFIGURE
  private func configureTableView(){
    optionsTableView.delegate = self
    optionsTableView.dataSource = self
    optionsTableView.rowHeight = 60
    optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  //MARK:- ACTIONS
  @IBAction func nextButtonTapped(_ sender: UIButton) {
    if let cell =  optionsTableView.cellForRow(at: IndexPath(row: selectedRow, section: 0)) {
      if cell.accessoryType == .none {
        showAlert("Please choose your answer")
        return
      }
      let selectedAnswer = questions.list[0].options[selectedRow]
      updateQuestions(selectedAnswer: selectedAnswer)
      if let vc = storyboard?.instantiateViewController(withIdentifier: "QuestionTwoVC") as? QuestionTwoVC {
        vc.userID = userID
        navigationController?.show(vc, sender: nil)
      }
    }
  }
  
  //MARK:- HELPERS
  func updateQuestions(selectedAnswer:String){
    let questionOne = self.questionLabel.text ?? ""
    let answer = Answers(answer: selectedAnswer)
    databaseRealm.updateQuestions(userID: userID ,answer: answer,question: questionOne)
  }
}

//MARK:- TABLE VIEW DATASOURCE
extension QuestionOneVC : UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questions.list[0].options.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = questions.list[0].options[indexPath.row]
    cell.selectionStyle = .none
    return cell
  }
}

//MARK:- TABLEVIEW DELEGATE
extension QuestionOneVC:UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
    selectedRow = indexPath.row
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .none
  }
}


