//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Krime Loma    on 9/1/22.
//

import UIKit

class HabitsViewController: UIViewController {
    
    var cellTitle : String?
    
    let hab = Habit(name: "Притворись тем кем хочешь и стать тем кем хочешь", date: Date(), color: .systemBlue)
    let hab1 = Habit(name: "Сходить в спортзал", date: Date(), color: .systemPink)
    let hab3 = Habit(name: "Почитать книгу", date: Date(), color: .systemMint)
    let hab4 = Habit(name: "Сделать уборку стола и квартиры", date: Date(), color: .systemPink)
    let hab5 = Habit(name: "Застелисть постель", date: Date(), color: .orange)


    func array () {
        habitArray.append(hab)
        habitArray.append(hab1)
        habitArray.append(hab3)
        habitArray.append(hab4)
        habitArray.append(hab5)
    }
    
    var habitArray : [Habit] = []

    
    private lazy var layoutCollection : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
       layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 16
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()
    
    private lazy var habitCollectionView : UICollectionView  = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layoutCollection)
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset.top = 22
        collection.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)

        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "Custom Cell")
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "Progress Cell")
        return collection
    } ()
    
    
    override func viewDidLoad() {
        array()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        setViews()
        setConstraints()
        setNavigation()
        configTabBar()
    }
    
    private func setViews() {
        self.view.addSubview(self.habitCollectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate( [
            self.habitCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.habitCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.habitCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.habitCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    
    // MARK:  NAVIGATION
    private func setNavigation() {
//        self.navigationController?.setToolbarHidden(false, animated: true)
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
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        habitArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      
        if indexPath.row == .zero {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Progress Cell", for: indexPath)
            print("🍏", cell.frame.height)
            
            cell.backgroundColor  = .white
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! HabitCollectionViewCell
            print(indexPath.row)
            cell.setup(habitsArray: habitArray, index: indexPath)
           
            print("🍏", cell.frame.height)
            cell.backgroundColor  = .white
            cell.layer.cornerRadius = 10
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
        
        let vc = DetailsViewController()
        vc.habitTitle = cellTitle
        
        self.navigationController?.pushViewController( vc , animated: true)
    }
    
    
    
}
