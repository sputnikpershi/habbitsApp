//
//  AddHabbitViewController.swift
//  MyHabits
//
//  Created by Krime Loma    on 9/4/22.
//

import UIKit

class AddHabbitViewController: UIViewController {
    
    var pickerTime: String = ""
    var name : String = ""
    var date = Date()
    var color : UIColor = .systemOrange
    
    private lazy var  nameLabel : UILabel = {
        let label = UILabel ()
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var  nameTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
   
    private lazy var  colorLabel : UILabel = {
        let label = UILabel ()
        label.text = "ЦВЕТ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var  colorPicker : UIImageView = {
        let color = UIImageView ()
        color.image = UIImage(systemName: "circle.fill")
        color.tintColor = .systemOrange
        color.isUserInteractionEnabled = true
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    } ()
    
    private lazy var  timeLabel : UILabel = {
        let label = UILabel ()
        label.text = "ВРЕМЯ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var  timeDescriprionLabel : UILabel = {
        let label = UILabel ()
        label.text = "Каждый день в \(String(describing: pickerTime))"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var  timeDataPicker : UIDatePicker = {
        let time = UIDatePicker ()
        time.datePickerMode = .time
        time.locale = NSLocale(localeIdentifier: "en_US") as Locale
        time.preferredDatePickerStyle = .wheels
        date = time.date
        time.translatesAutoresizingMaskIntoConstraints = false
        time.addTarget(self, action: #selector(handler(sender:)), for: UIControl.Event.valueChanged)
        return time
    } ()
    
    @objc func handler(sender:UIDatePicker) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        let strDate = timeFormatter.string(from: (timeDataPicker.date))
        print("=)) \(strDate)")
        pickerTime = strDate
        
    }
    
    private lazy var  deleteLabel : UILabel = {
        let label = UILabel ()
        label.text = "Удалить привычку"
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    
    
    // MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        self.title = "Создать"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
        setViews()
        setConstraint()
        setGesture()
    }
    
    private func setNavigation () {
//        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveAction))
    }

    @objc func  saveAction () {
        let newHabit = Habit(name: name, date: date, color: color)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        print(newHabit)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    private func setViews() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameTextField)
        self.view.addSubview(colorLabel)
        self.view.addSubview(colorPicker)
        self.view.addSubview(timeLabel)
        self.view.addSubview(timeDescriprionLabel)
        self.view.addSubview(timeDataPicker)
        self.view.addSubview(deleteLabel)

    }
    
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
                   self.nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                   self.nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
        
                   self.nameTextField.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 7),
                   self.nameTextField.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
                   self.nameTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width - 32),

        
                   self.colorLabel.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 15),
                   self.colorLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
                   
                   self.colorPicker.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 7),
                   self.colorPicker.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
                   self.colorPicker.heightAnchor.constraint(equalToConstant: 30),
                   self.colorPicker.widthAnchor.constraint(equalToConstant: 30),
                   
                   self.timeLabel.topAnchor.constraint(equalTo: self.colorPicker.bottomAnchor, constant: 15),
                   self.timeLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
                   
                   self.timeDescriprionLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 7),
                   self.timeDescriprionLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
                   
                   self.timeDataPicker.topAnchor.constraint(equalTo: self.timeDescriprionLabel.bottomAnchor, constant:  15),
                   self.timeDataPicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                   self.timeDataPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
                   self.timeDataPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
                   
                   
                   self.deleteLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                   self.deleteLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -18)
                   
                   

  ]) }
    
    
    
    private func setGesture() {
        colorPicker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAction)))
    }
    
    @objc private func handleTapAction() {
        
        print("🍏, Touch")
//        self.view.backgroundColor = .white
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = .systemOrange
        colorPicker.title = "Выберите цвет"
        present(colorPicker, animated: true, completion: nil)
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

extension AddHabbitViewController : UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorPicker.tintColor = viewController.selectedColor
    }

    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("🍏, Dissmis")
        
    }
    
}
