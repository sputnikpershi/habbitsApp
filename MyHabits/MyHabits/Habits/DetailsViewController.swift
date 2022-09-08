//
//  DetailsViewController.swift
//  MyHabits
//
//  Created by Krime Loma    on 9/4/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var habitTitle: String?
    
    private lazy var EditTableView: UITableView = {
        let timeTable = UITableView()
        timeTable.delegate = self
        timeTable.dataSource = self
        timeTable.register(UITableViewCell.self, forCellReuseIdentifier: "Custom cell")
        timeTable.translatesAutoresizingMaskIntoConstraints = false
        return  timeTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPurple
        self.title = habitTitle
        setViews()
        setConstraints()
        setNavifation()
        // Do any additional setup after loading the view.
    }
    
    
    private func setNavifation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editAction))

        
        
    }
                                                                                  
    private func setViews() {
        self.view.addSubview(EditTableView)
    }
    
    @objc func editAction () {
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.EditTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.EditTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.EditTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.EditTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .gray
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "AКТИВНОСТЬ"
    }
    
    
}
