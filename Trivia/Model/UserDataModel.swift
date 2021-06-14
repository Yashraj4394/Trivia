//
//  UserDataModel.swift
//  Trivia
//
//  Created by YashraJ Gujar on 14/06/21.
//

import RealmSwift

class UserData : Object {
  @objc dynamic var userName : String = ""
  @objc dynamic var questionOne : String = ""
  @objc dynamic var questionTwo : String = ""
  var answersOne = List<Answers>()
  var answersTwo = List<Answers>()
  @objc dynamic var timestamp : Double = 0.0
  @objc dynamic var userID : String = ""
  @objc dynamic var gameNumber : Int = 0
  
  override class func primaryKey() -> String? {
    return "userID"
  }
  
  convenience init(userName : String,userID:String,gameNumber:Int){
    self.init()
    self.userName = userName
    self.timestamp = Double(Int(NSDate().timeIntervalSince1970))
    self.userID = userID
    self.gameNumber = gameNumber
  }
}

class Answers : Object {
  @objc dynamic var answer : String = ""
  required convenience init(answer:String){
    self.init()
    self.answer = answer
  }
}
