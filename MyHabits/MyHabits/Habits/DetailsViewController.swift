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
    
    private lazy var EditTableView: UITableView = {
        let timeTable = UITableView()
        timeTable.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        timeTable.delegate = self
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
        cell.textLabel?.text =  HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        print(habit.trackDates.count)
        
        for i in habit.trackDates {
            print(i)
            if HabitsStore.shared.habit(habit, isTrackedIn: i) {
                print(HabitsStore.shared.habit(habit, isTrackedIn: i))
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { "AКТИВНОСТЬ" }
}






