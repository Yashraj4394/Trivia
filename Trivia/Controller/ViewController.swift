//
//  ViewController.swift
//  Trivia
//
//  Created by YashraJ Gujar on 14/06/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  
  //MARK:- OUTLETS
  @IBOutlet weak var nameTextField: UITextField!
  
  //MARK:- PROPERTIES
  private var gameNumber = 0
  private let databaseRealm = DatabaseUpdates()
  //MARK:- LIFECYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Realm file location :",Realm.Configuration.defaultConfiguration.fileURL ?? "")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.nameTextField.text = ""
    self.getGameNumber()
  }
  
  //MARK:- ACTIONS
  @IBAction func nextTapped(_ sender: Any) {
    nameTextField.resignFirstResponder()
    guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces),name.count>0 else {
      self.showAlert("Please enter name")
      return
    }
    let userID = UUID().uuidString
    self.updateDB(userName: name.trimmingCharacters(in: .whitespaces), userID: userID)
    if let vc = storyboard?.instantiateViewController(withIdentifier: "QuestionOneVC") as? QuestionOneVC {
      vc.userID = userID
      navigationController?.show(vc, sender: nil)
    }
  }
  
  //MARK:- HELPERS
  private func updateDB(userName : String,userID:String){
    let realm = try! Realm()
    do {
      try realm.write {
        realm.add(UserData(userName: userName,userID: userID,gameNumber: gameNumber))
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func getGameNumber(){
    gameNumber = databaseRealm.getGameNumber() + 1
  }
}

//MARK:- TEXTFIELD DELEGATE
extension ViewController : UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    return newText.count < 30
  }
}

