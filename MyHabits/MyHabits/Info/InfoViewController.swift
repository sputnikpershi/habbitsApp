//
//  InfoViewController.swift
//  MyHabits
//
//  
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var scrolView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var headerLabel  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Этапы вырабатывания привычки привычки привычки"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(600))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoTextView : UILabel = {
        let info = UILabel()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.numberOfLines = 0
        info.text  = """

Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

Источник: psychbook.ru

"""
        info.font =  info.font?.withSize(17)
        info.textAlignment = .left
        return info
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        setViews()
        setConstraints()
        setNavigation()
    }
    
    
    private func setNavigation () {
        self.navigationItem.title = "Информация"
    }
    
    
    private func setViews () {
        self.view.addSubview(self.scrolView)
        self.scrolView.addSubview(stackView)
        self.scrolView.addSubview(headerLabel)
        self.scrolView.addSubview(infoTextView)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(infoTextView)
        self.view.addSubview(self.headerLabel)
        self.view.addSubview(self.infoTextView)
    }
    
    
    private func setConstraints () {
        NSLayoutConstraint.activate([
            self.scrolView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrolView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.scrolView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.scrolView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            self.stackView.topAnchor.constraint(equalTo: self.scrolView.topAnchor),
            self.stackView.centerXAnchor.constraint(equalTo: self.scrolView.centerXAnchor),
            self.stackView.widthAnchor.constraint(equalTo: self.scrolView.widthAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrolView.bottomAnchor),
            
            
            self.headerLabel.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant:  22),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 16),
            self.headerLabel.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, constant: -32 ),
            
            
            self.infoTextView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 16 ),
            self.infoTextView.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor),
            self.infoTextView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, constant: -32),
            self.infoTextView.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
        ])
    }
}
