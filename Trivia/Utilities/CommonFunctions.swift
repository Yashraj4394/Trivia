//
//  CommonFunctions.swift
//  Trivia
//
//  Created by YashraJ Gujar on 15/06/21.
//

import Foundation

func getDate(time:Double)->String{
  let dateFormatter = DateFormatter()
  dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
  dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
  dateFormatter.timeZone = .current
  let date = Date(timeIntervalSince1970: time)
  let localDate = dateFormatter.string(from: date)
  return localDate
}
