//
//  TaskNameCell.swift
//  Estimated
//
//  Created by Daniel Aditya Istyana on 15/07/19.
//  Copyright © 2019 Daniel Aditya Istyana. All rights reserved.
//

import UIKit

protocol TaskNameDelegate: class {
  func finishAddingTaskName(taskName: String)
  func checkTextFieldText(charactersCount: Int)
}


class TaskNameCell: UITableViewCell, UITextFieldDelegate {
  
  weak var taskNameCellDelegate: TaskNameDelegate?
  
  @IBOutlet weak var taskNameTextField: UITextField!
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    
    // trigger delegate
    self.taskNameCellDelegate?.checkTextFieldText(charactersCount: updatedText.count)
    self.taskNameCellDelegate?.finishAddingTaskName(taskName: taskNameTextField.text!)
   
    return updatedText.count <= 60
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.taskNameCellDelegate?.finishAddingTaskName(taskName: textField.text!)
    textField.resignFirstResponder()
    return true
  }
  
}
