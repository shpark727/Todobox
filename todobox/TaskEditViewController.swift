//
//  TaskEditViewController.swift
//  todobox
//
//  Created by 박성환 on 2017. 5. 24..
//  Copyright © 2017년 sunghwan. All rights reserved.
//


// show 는 stack으로 
// showDetail 은 밑에서 위로 (새로운 아이템 추가하거나 모달창 띄우거나 할때.. 완전 별개의 viewcontroller ) 

import Foundation
import UIKit // UIViewController 쓰기 위해 

class TaskEditViewController: UIViewController {
  
  @IBOutlet var textField: UITextField!
  var didAddTask: ((Task) -> Void)?
  
    @IBAction func cancelButtonDidTap(){
        textField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil) 
        
    }
  
  @IBAction func doneButtonDidTap() {
    
    textField.resignFirstResponder()
    
    // Early return 혹은 Golden path
    //guard 로 감싼 부분의 값을 그 밑에 라인에서도 (같은 depth)에서 그냥 쓸 수 있다
    guard let title = textField.text, !title.isEmpty else {
      shakeTextField()
      return
    }
    
      let task = Task(title: title, isDone: false)
      didAddTask?(task)
      self.dismiss(animated: true, completion: nil)
      
      
      
      //1. Alert (UX상..) 2. textmessage로 알림 3. 흔들리는 모션
      
      /* 금지!! 재사용을 못하는 코드 TaskListViewController에서 안부르면 땡이므로...
      if let nav = self.presentingViewController as? UINavigationController{
        if let vc = nav.viewControllers.first as? TaskListViewController{
          vc.tasks.append(task)
          vc.tableView.reloadData()
        }
      }// 나를 불렀던 그 뷰를 부른다 ( 여기서는 navigatoinViewController )
    }
 
 */
    
  }
  
  func shakeTextField() {
    UIView.animate(
      withDuration: 0.3,
      animations: {
        self.textField.frame.origin.x += 10
        
      },
      completion: { _ in
        UIView.animate(
          withDuration: 0.3,
          animations: {
            self.textField.frame.origin.x -= 20
            
          },
          completion: { _ in
            UIView.animate(
              withDuration: 0.3,
              animations: {
                self.textField.frame.origin.x += 10
                
              },
              completion: { _ in
            })
            
            
        })
        
      })
    
    
    //CGRect origin: CGPoint , size: CGSize
  }
    
    
}


