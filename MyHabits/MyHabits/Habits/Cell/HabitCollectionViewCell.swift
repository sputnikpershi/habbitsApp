//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Krime Loma    on 9/4/22.
//

import UIKit


class HabitCollectionViewCell: UICollectionViewCell {
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel ()
        label.numberOfLines = 2
        label.font =  label.font.withSize(17)
        label.text =  "Выпить стакан воды"
        label.translatesAutoresizingMaskIntoConstraints = false
        let habit = HabitsStore.shared.habits
        print (habit)
        return label
    } ()
    
    private lazy  var timeLabel: UILabel = {
        let label = UILabel ()
        label.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        label.font = label.font.withSize(13)
        label.text =  "Каждый день в 7:00"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    } ()
    
    private lazy  var counterLabel: UILabel = {
        let label = UILabel ()
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
//        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.font = label.font.withSize(13)
        label.text =  "Счесткик: 4"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy  var enableTickImage: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "checkmark.circle.fill")
// checkmark.circle.fill and circle
        return image
    } ()
    
    private lazy  var disableTickImage: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "circle")
        image.tintColor = .purple
// checkmark.circle.fill and circle
        return image
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setViews () {
        self.addSubview(self.nameLabel)
        self.addSubview(self.timeLabel )
        self.addSubview(self.counterLabel)
        self.addSubview(self.enableTickImage)
        self.addSubview(self.disableTickImage)
    }
    
    private func setConstrains () {
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 155),
          
            
            self.timeLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.timeLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor ,constant: 4),

            self.counterLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            self.counterLabel.topAnchor.constraint(lessThanOrEqualTo: timeLabel.bottomAnchor, constant: 30),
            self.counterLabel.bottomAnchor .constraint(equalTo: self.bottomAnchor,constant: -20),


            self.disableTickImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            self.disableTickImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.disableTickImage.widthAnchor.constraint(equalToConstant: 38),
            self.disableTickImage.heightAnchor.constraint(equalToConstant: 38),
            
            self.enableTickImage.topAnchor.constraint(equalTo: self.disableTickImage.topAnchor,constant: 2),
            self.enableTickImage.leadingAnchor.constraint(equalTo: disableTickImage.leadingAnchor, constant: 2),
            self.enableTickImage.trailingAnchor.constraint(equalTo: disableTickImage.trailingAnchor, constant: -2),
            self.enableTickImage.bottomAnchor.constraint(equalTo: disableTickImage.bottomAnchor, constant: -2)
        ])
    }
    
    func setup (habitsArray: [Habit], index: IndexPath) {
        nameLabel.text =  habitsArray[index.row - 1].name
        enableTickImage.tintColor = habitsArray[index.row - 1].color
        timeLabel.text = habitsArray[index.row - 1].dateString
        print("🤪, \(timeLabel.text)")
    }
    

    
}
