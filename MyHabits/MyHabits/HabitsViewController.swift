//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Krime Loma    on 9/1/22.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationController?.navigationBar.prefersLargeTitles = true
     title = "First"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabbit))
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc  func   addHabbit() {
        
    }
    
//    private func setNavigation () {
//        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 0.8)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
