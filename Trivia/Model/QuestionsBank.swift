//
//  QuestionsBank.swift
//  Trivia
//
//  Created by YashraJ Gujar on 15/06/21.
//

import Foundation

struct Questions {
  let question: String
  let options : [String]
}

class QuestionBank {
  
  var list = [Questions]()
  
  init() {
    let questionOne = Questions(question: "Who is the best cricketer in the world?", options: ["A) Sachin Tendulkar","B) Virat Kolli","C) Adam Gilchirst","D) Jacques Kallis"])
    list.append(questionOne)
    
    let questionTwo = Questions(question: "What are the colors in the Indian national flag?", options: ["A) White","B) Yellow","C) Orange","D) Green"])
    list.append(questionTwo)
  }
}
