//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Krime Loma on 7/9/22.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var progressToday = HabitsStore.shared.todayProgress

    private lazy var titleLabel: UILabel = {
        let label = UILabel ()
        label.numberOfLines = 2
        label.font =  label.font.withSize(17)
        label.text =  "Все получится!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel ()
        label.numberOfLines = 2
        label.font =  label.font.withSize(17)
        label.text =  "\(progressToday)%"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.setProgress(progressToday, animated: true)
        progress.layer.cornerRadius = 3.5
        progress.clipsToBounds = true
        
        progress.trackTintColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1)
        progress.progressTintColor = UIColor(red: 0.631, green: 0.086, blue: 0.8, alpha: 1)
        progress.translatesAutoresizingMaskIntoConstraints = false
      
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    private func setViews() {
        self.addSubview(titleLabel)
        self.addSubview(percentageLabel)
        self.addSubview(progressView)

    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
        
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:  12),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            self.percentageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:  12),
            self.percentageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),

            self.progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  10),
            self.progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            self.progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            self.progressView.heightAnchor.constraint(equalToConstant: 7)
        
        ])
    }
    
}
