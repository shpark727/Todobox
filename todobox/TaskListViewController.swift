//
//  TaskListViewController.swift
//  todobox
//
//  Created by 박성환 on 2017. 5. 22..
//  Copyright © 2017년 sunghwan. All rights reserved.
//

// closure 의 단점 

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet var tableView: UITableView! // !붙여서 implicited optional 해준다

    
    
    //* 1.String을 Task의 배열로 바꿔보세요
    //  2.cell의 텍스트 라벨에서 Task.title이 보이도록 해보세요.
    
    var tasks: [Task] = [
        
        Task(title: "청소하기", isDone: false) ,
        Task(title: "빨래하기", isDone: true) ,
        Task(title: "이슈 생성하기", isDone: false)
        
    ]
    
    // MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
    }
    
        
        // Do any additional setup after loading the view, typically from a nib.
        // 스토리 보드의 모든 UI 요소가 올라간 직후에 호출!

  
  // NSNotification -> Notification
  // NSDate -> Date
  // NSNumber -> NSNumber
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if let nav = segue.destination as? UINavigationController {
      if let vc = nav.viewControllers.first as? TaskEditViewController {
        vc.didAddTask = { [weak self] task in  // closure의 단점은 list <-> Edit 이게 둘이 강하게 묶여있다. 따라서 하나를 weak으로 만든다.
            self?.tasks.append(task)
            self?.tableView.reloadData()
        }
      }
    }
  }
}

// MARK: - UITableViewDataSource


//datasource - 테이블의 기본적 정보
// 체크가 되어있는지 확인하려면 uitableviewdelegate => 테이블뷰의 행동, 셀의 크기 등을 정의할때 사용한다 ! 

extension TaskListViewController: UITableViewDataSource{
    
    
    // 필수메소드 아래 두가지 ..
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //UITableViewCell() <- 이렇게 계속 새로 만들게되면 자원의 낭비이므로 자원을 재활용하기위해 아래코드처럼 작성함
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) //스크롤 내리면 맨 위에있던 cell을 재사용함
        
        
        /* 굉장히 비효율적이기 때문에 */
        //let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title //cell.textLabel?.text = tasks[indexPath.row]   // IndexPath에는 섹션/row 정보가 들어있다
        
        
        if task.isDone {
            cell.accessoryType = .checkmark
        
        } else {
            cell.accessoryType = .none
        }

        
        //* cell을 재사용하는 경우 체크되어있는지 안되있는지 처리해줘야한다. */ 
        
        return cell
        
    }
}

// MARK: - UITableViewDelegate

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldTask = self.tasks[indexPath.row]
        let newTask = Task(title: oldTask.title, isDone: !oldTask.isDone)
        self.tasks[indexPath.row] = newTask 
        
        
        // UI한테 tableview 업데이트하라고 시킴.reloadData는 애니메이션없이 화면에 보이는 모든걸 업뎃, reloadRows는 애니메이션 + 해당 row만 업뎃
     //   tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }

}

















