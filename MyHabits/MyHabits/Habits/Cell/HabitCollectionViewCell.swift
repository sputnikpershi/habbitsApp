//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  
//

import UIKit

protocol CheckedCollectionViewCellDelegate : AnyObject {
    func updateProgress()
}


class HabitCollectionViewCell: UICollectionViewCell {
    
    weak var cellDelegate : CheckedCollectionViewCellDelegate?
    var selectedAtIndex: IndexPath?
    weak var progress: ProgressCollectionViewCell?
    var daysCheckedArray: [IndexPath : [Date]] = [[1, 0]: [Date()]]
    
    lazy var nameLabel: UILabel = {
        let label = UILabel ()
        label.numberOfLines = 2
        label.font =  label.font.withSize(17)
        label.translatesAutoresizingMaskIntoConstraints = false
        let habit = HabitsStore.shared.habits
        return label
    } ()
    
    private lazy  var timeLabel: UILabel = {
        let label = UILabel ()
        label.textColor = UIColor(red: 0.682, green: 0.682, blue: 0.698, alpha: 1)
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy  var counterLabel: UILabel = {
        let label = UILabel ()
        label.textColor = UIColor(red: 0.557, green: 0.557, blue: 0.576, alpha: 1)
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy  var enableCheckMarkImage: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "checkmark.circle.fill")
        return image
    } ()
    
    private lazy  var disableCheckMarkImage: UIImageView = {
        let image = UIImageView ()
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "circle")
        return image
    } ()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstrains()
        setGestureRecognizer()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setViews () {
        self.addSubview(self.nameLabel)
        self.addSubview(self.timeLabel )
        self.addSubview(self.counterLabel)
        self.addSubview(self.enableCheckMarkImage)
        self.addSubview(self.disableCheckMarkImage)
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
            
            
            self.disableCheckMarkImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            self.disableCheckMarkImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.disableCheckMarkImage.widthAnchor.constraint(equalToConstant: 38),
            self.disableCheckMarkImage.heightAnchor.constraint(equalToConstant: 38),
            
            self.enableCheckMarkImage.topAnchor.constraint(equalTo: self.disableCheckMarkImage.topAnchor,constant: 2),
            self.enableCheckMarkImage.leadingAnchor.constraint(equalTo: disableCheckMarkImage.leadingAnchor, constant: 2),
            self.enableCheckMarkImage.trailingAnchor.constraint(equalTo: disableCheckMarkImage.trailingAnchor, constant: -2),
            self.enableCheckMarkImage.bottomAnchor.constraint(equalTo: disableCheckMarkImage.bottomAnchor, constant: -2)
        ])
    }
    
    
    func setup (habitsArray: [Habit], index: IndexPath) {
        if index.section == 1 {
            nameLabel.text =  habitsArray[index.row].name
            timeLabel.text = habitsArray[index.row].dateString
            disableCheckMarkImage.tintColor = habitsArray[index.row].color
            counterLabel.text =  "Счетчик: \(HabitsStore.shared.habits[index.row].trackDates.count)"

            if habitsArray[index.row].isAlreadyTakenToday {
                enableCheckMarkImage.tintColor = habitsArray[index.row ].color
                enableCheckMarkImage.isHidden = false
                enableCheckMarkImage.isUserInteractionEnabled = false
                disableCheckMarkImage.isUserInteractionEnabled = false
            } else {
                enableCheckMarkImage.tintColor = habitsArray[index.row ].color
                enableCheckMarkImage.isHidden = true
                enableCheckMarkImage.isUserInteractionEnabled = true
                disableCheckMarkImage.isUserInteractionEnabled = true
            }
        }
    }
    
    
    private func setGestureRecognizer () {
        disableCheckMarkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    @objc private func handleTap () {
        guard let index = selectedAtIndex else {return}
        let habit = HabitsStore.shared.habits[index.row]
        
            
            HabitsStore.shared.track(habit)
            print(habit.trackDates.count, "+1")
            cellDelegate?.updateProgress()
            enableCheckMarkImage.isHidden = false
        enableCheckMarkImage.isUserInteractionEnabled = false
        disableCheckMarkImage.isUserInteractionEnabled = false //   проверить работу

            print("\(HabitsStore.shared.habits[index.row].name)  привычка -   затрекана")
        
    }
}

