//
//  AddHabbitViewController.swift
//  MyHabits
//
//  
//

import UIKit

protocol AddHabbitViewControllerDelegate: AnyObject { // protocol for passing data form AddHabitVIewController to  HabitsViewController
    func addItem(with index: Int)
    func deleteItem(with indexPath: IndexPath)
    func editItem(with indexPath: IndexPath)
}

class AddHabbitViewController: UIViewController {
    
    var isEditingItem = false
    var editIndexPath: IndexPath?
    weak var habitVC: AddHabbitViewControllerDelegate?
    weak var detailVC: DetailsViewController?
    
    
    private lazy var  nameLabel : UILabel = {
        let label = UILabel ()
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var  nameTextField : UITextField = {
        let textField = UITextField()
        textField.enablesReturnKeyAutomatically = true
        textField.autocapitalizationType = .sentences
        textField.returnKeyType = .done
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
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
        let date = Date()
        label.text = "Каждый день в \(formatDateToShortStyle(date:date))"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private lazy var  timeDataPicker : UIDatePicker = {
        let time = UIDatePicker ()
        time.datePickerMode = .time
        time.locale = NSLocale(localeIdentifier: "en_US") as Locale
        time.preferredDatePickerStyle = .wheels
        time.translatesAutoresizingMaskIntoConstraints = false
        time.addTarget(self, action: #selector(handler(sender:)), for: UIControl.Event.valueChanged)
        return time
    } ()
    
    
    @objc func handler(sender:UIDatePicker) {
        timeDescriprionLabel.text = "Каждый день в \(formatDateToShortStyle(date: timeDataPicker.date))"
    }
    
    
    private lazy var  deleteLabel : UILabel = {
        let label = UILabel ()
        label.text = "Удалить привычку"
        label.textColor = .systemRed
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    } ()
    
    
    // MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Создать"
        setNavigation()
        setViews()
        setConstraint()
        setGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        configurationEditingCell()
    }
    
    
    private func  configurationEditingCell (){
        if isEditingItem {
            deleteLabel.isHidden = false
            let index = editIndexPath ?? [0,0]
            let editItem = HabitsStore.shared.habits[index.row]
            self.title = "Редактировать"
            nameTextField.text = editItem.name
            timeDataPicker.date = editItem.date
            colorPicker.tintColor = editItem.color
            timeDescriprionLabel.text = "Каждый день в \(formatDateToShortStyle(date: editItem.date))"
        }
    }
    
    
    private func setNavigation () {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelAction))
        
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
        deleteLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDeletAction)))
    }
    
    
    @objc private func handleTapAction() {
        print("🍏, Touch UIColorPicker")
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = .systemOrange
        colorPicker.title = "Выберите цвет"
        present(colorPicker, animated: true, completion: nil)
    }
    
    
    @objc private func handleDeletAction () {
        let index = editIndexPath ?? [1,0]
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(HabitsStore.shared.habits[index.row].name)?", preferredStyle: .alert)
        let cancel  = UIAlertAction(title: "Отменить", style: .cancel) { _ in }
        let delete  = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            
            HabitsStore.shared.habits.remove(at: index.row) // Delete Item at Index = index.row
            self.habitVC?.deleteItem(with: index)
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertController.addAction(cancel)
        alertController.addAction(delete)
        self.present(alertController, animated: true)
    }
    
    
    func formatDateToShortStyle (date: Date) -> String{
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        return timeFormatter.string(from: (date))
    }
    
    
    @objc func  saveAction () {
        
        if isEditingItem {
            let index = editIndexPath ?? [1,0]
            let editItem = HabitsStore.shared.habits[index.row]
            editItem.name = nameTextField.text ?? ""
            editItem.date = timeDataPicker.date
            editItem.color = colorPicker.tintColor
            HabitsStore.shared.save()
            habitVC?.editItem(with: index)
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            let newHabit = Habit(name: nameTextField.text ?? "", date: timeDataPicker.date, color: colorPicker.tintColor)
            HabitsStore.shared.habits.append(newHabit)
            let index = HabitsStore.shared.habits.endIndex
            habitVC?.addItem(with: index)
            self.navigationController?.popToRootViewController(animated: true)
            isEditing = false
        }
    }
    
    
    @objc func cancelAction () {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    func setEditingInfoItem (indexPath: IndexPath) {
        editIndexPath = indexPath
    }
}

// MARK: EXTENSION

extension AddHabbitViewController : UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorPicker.tintColor = viewController.selectedColor
    }
    
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("🍏, Dissmis UIColorPicker")
    }
}




