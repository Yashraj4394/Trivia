//
//  Extensions.swift
//  Trivia
//
//  Created by YashraJ Gujar on 14/06/21.
//

import UIKit

extension UIViewController {
  func showAlert(_ message:String){
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
