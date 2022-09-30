//
//  HabitsViewController.swift
//  MyHabits
//
//  
//

import UIKit

class HabitsViewController: UIViewController {
    
    var cellTitle : HabitCollectionViewCell?
    private lazy var layoutCollection : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 16
        return layout
    }()
    
    private lazy var habitCollectionView : UICollectionView  = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layoutCollection)
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset.top = 22
        collection.contentInset.bottom = 22
        collection.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "Custom Cell")
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "Progress Cell")
        return collection
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        
        
        setViews()
        setConstraints()
        setNavigation()
        configTabBar()
        print("Таблица хранит \(HabitsStore.shared.habits.count) ячеек")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func setViews() {
        self.view.addSubview(self.habitCollectionView)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate( [
            self.habitCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.habitCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.habitCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.habitCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    // MARK:  NAVIGATION
    
    
    private func setNavigation() {
        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabbit))
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
    }
    
    
    // MARK:  TABBAR
    
    
    private func configTabBar () {
        self.tabBarController?.tabBar.tintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
    }
    
    
    @objc  func   addHabbit() {
        let vc = AddHabbitViewController ()
        vc.habitVC = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: 0, height: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        habitCollectionView.reloadData()
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == .zero {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Progress Cell", for: indexPath) as! ProgressCollectionViewCell
            cell.backgroundColor  = .white
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
            cell.percentageLabel.text =  "\(round(HabitsStore.shared.todayProgress * 100))%"
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! HabitCollectionViewCell
            cell.setup(habitsArray: HabitsStore.shared.habits, index: indexPath)
            cell.backgroundColor  = .white
            cell.layer.cornerRadius = 10
            cell.cellDelegate = self
            cell.selectedAtIndex = indexPath
            cell.clipsToBounds = true
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width - 32
        let height = 135
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = DetailsViewController()
            vc.habitVC = self 
            vc.selectedAtIndex = indexPath
            print(" Выбрана ячейка - \(HabitsStore.shared.habits[indexPath.row].name) с индексом \(indexPath)")
            print ("Ячейка затрекана \(HabitsStore.shared.habits[indexPath.row].trackDates.count) раз")
            self.navigationController?.pushViewController( vc , animated: true)
        }
        
    }
}

// MARK: EXTENSION


extension HabitsViewController:  AddHabbitViewControllerDelegate {
    func deleteItem(with indexPath: IndexPath) {  // Reload Data after deleting Item
        self.habitCollectionView.performBatchUpdates {
            print("☘️: delete")
            habitCollectionView.deleteItems(at: [indexPath])
        }
    }
    
    
    func editItem(with indexPath: IndexPath) {  // Relaod data after editing item
        self.habitCollectionView.performBatchUpdates {
            print("☘️: edit)")
            habitCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    
    func addItem(with index: Int) {   // Reload Data for after adding item
        self.habitCollectionView.performBatchUpdates {
            print("☘️: add)")
            habitCollectionView.insertItems(at: [IndexPath(row: index - 1, section: 1)])
            let index = IndexPath(row: 0, section: 0)
            self.habitCollectionView.reloadItems(at: [index])
        }
    }
}


extension HabitsViewController: CheckedCollectionViewCellDelegate {   // Reload Data of ProgressView
    func updateProgress() {
        self.habitCollectionView.performBatchUpdates {
            let index = IndexPath(row: 0, section: 0)
            self.habitCollectionView.reloadItems(at: [index])
            print("☘️: update progress view)")
        }
    }
}
