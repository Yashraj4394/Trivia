//
//  UserDataViewModel.swift
//  Trivia
//
//  Created by YashraJ Gujar on 15/06/21.
//

import Foundation
struct UserDataViewModel {
  
  var data : UserData
  
  init(data:UserData) {
    self.data = data
  }
  
  var userName : String {
    return "Name: \(data.userName)"
  }
  
  var gameNumber : String {
    return "Game: \(data.gameNumber)"
  }
  
  var timeStamp : String {
    return getDate(time: data.timestamp)
  }
  
  var questionOne : String {
    return data.questionOne
  }
  
  var questionTwo : String {
    return data.questionTwo
  }
  
  var answerOne : String {
    let array = Array(data.answersOne).map({$0.answer})
    return array.joined()
  }
  
  var answerTwo : String {
    let array = Array(data.answersTwo).map({$0.answer})
    return array.joined(separator: ",")
  }
}
