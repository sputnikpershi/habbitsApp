//
//  DetailsViewController.swift
//  MyHabits
//
//  
//

import UIKit


class DetailsViewController: UIViewController {
    
    var habitTitle: String?
    var selectedAtIndex: IndexPath?
    var habitVC: AddHabbitViewControllerDelegate?
    
    private lazy var EditTableView: UITableView = {
        let timeTable = UITableView()
        timeTable.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        timeTable.delegate = self
        //        timeTable.transform = CGAffineTransform(scaleX: 1, y: -1)
        //        timeTable.transform = CGAffineTransform(rotationAngle: (-.pi))
        
        
        timeTable.dataSource = self
        timeTable.register(UITableViewCell.self, forCellReuseIdentifier: "Custom cell")
        timeTable.translatesAutoresizingMaskIntoConstraints = false
        return  timeTable
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  HabitsStore.shared.habits[selectedAtIndex?.row ?? 0].name
        setViews()
        setConstraints()
        setNavifation()
        self.view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
    }
    
    
    private func setNavifation() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editAction))
    }
    
    
    private func setViews() {
        self.view.addSubview(EditTableView)
    }
    
    
    @objc func editAction () {
        let vc = AddHabbitViewController()
        vc.habitVC = habitVC
        vc.editIndexPath = selectedAtIndex
        vc.isEditingItem = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.EditTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.EditTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.EditTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.EditTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

// MARK: EXTENSION

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return configCell(cell: cell, with: indexPath)
    }
    
    
    func configCell (cell: UITableViewCell, with indexPath: IndexPath) -> UITableViewCell {
        let habit = HabitsStore.shared.habits[selectedAtIndex?.row ?? 0]
        let reverseIndex = HabitsStore.shared.dates.count - indexPath.row - 1
        cell.textLabel?.text =  HabitsStore.shared.trackDateString(forIndex: reverseIndex)
        var indexes: [Int] = []
        
        for i in 0..<HabitsStore.shared.dates.count {
            if  HabitsStore.shared.habit(habit, isTrackedIn: HabitsStore.shared.dates[i]){
                indexes.append(i)
            }
        }
        
        for i in indexes {
            if reverseIndex == i {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "AКТИВНОСТЬ" }
}




