//
//  DatabaseUpdates.swift
//  Trivia
//
//  Created by YashraJ Gujar on 15/06/21.
//

import RealmSwift

class DatabaseUpdates : NSObject {
  
  func addUser(name : String,userID : String){
    let gameNumber = self.getGameNumber() + 1
    let realm = try! Realm()
    do {
      try realm.write {
        realm.add(UserData(userName: name,userID: userID,gameNumber: gameNumber))
      }
    } catch {
      print(error.localizedDescription)
    }
    
  }
  func updateQuestions(userID :String,answer:Answers,question : String){
    let predicate = NSPredicate(format: "userID = '\(userID)'")
    let realm = try! Realm()
    if let data = realm.objects(UserData.self).filter(predicate).first {
      do {
        try realm.write({
          data.questionOne = question
          data.answersOne.append(answer)
        })
      } catch {
        print("error updating question and answers:",error.localizedDescription)
      }
    }
  }
  
  func updateQuestionTwo(userID :String,answer:[Answers],question : String){
    let predicate = NSPredicate(format: "userID = '\(userID)'")
    let realm = try! Realm()
    if let data = realm.objects(UserData.self).filter(predicate).first {
      do {
        try realm.write({
          data.questionTwo = question
          data.answersTwo.append(objectsIn: answer)
        })
      } catch {
        print("error updating question and answers:",error.localizedDescription)
      }
    }
  }
  
  func fetchUserData(userID:String,completion : @escaping(UserData)->Void){
    let predicate = NSPredicate(format: "userID = '\(userID)'")
    let realm = try! Realm()
    if let data = realm.objects(UserData.self).filter(predicate).first {
      completion(data)
    }
  }
  
  func fetchAllData(completion : @escaping([UserDataViewModel])->Void){
    let realm = try! Realm()
    let data = realm.objects(UserData.self)
    var viewModel = [UserDataViewModel]()
    for x in data {
      viewModel.append(UserDataViewModel(data: x))
    }
    completion(viewModel)
  }
  
  func getGameNumber()->Int{
    let realm = try! Realm()
    if let data = realm.objects(UserData.self).sorted(byKeyPath: "timestamp", ascending: false).first {
      return data.gameNumber
    } else {
      return 0
    }
  }
}
