//
//  TaskDetailsViewController.swift
//  TODOLIST_GRUPO4
//
//  Created by Matheus Lenke on 27/03/22.
//

import UIKit

enum ViewActions {
    case save
    case dismiss
    case delete
}

protocol ViewActionsDelegate {
    func completeAction(actionType: ViewActions) -> Void
    func setNewTask(_ task: Task) -> Void
}

class TaskDetailsViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    
    var delegate: TasksDataManagerDelegate?
    var task: Task? = nil {
        didSet {
            if let task = task {
                taskTitleLabel.text = task.title
                taskDescriptionTextView.text = task.description
                if task.completed {
                    doneButton.isHidden = true
                }
            }
        }
    }
        
    // MARK: Layout vars
    
    lazy var taskDetailsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Detalhes da Tarefa"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 1
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Título:"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var taskTitleLabel: UITextField = {
        let textField = UITextField()
        textField.text = "Título da Task"
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição:"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var taskDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.autocapitalizationType = .sentences
        textView.autocorrectionType = .default
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.keyboardType = .default
        textView.text = "Descrição da task"
        return textView
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.label.cgColor
        button.setTitle("Marcar como concluída", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
        button.setTitleColor(UIColor.label, for: .normal)
        return button
    }()

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide
        configUI()
    }
    
    // MARK: UI Configurations
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(editTask))
        
        view.addSubview(taskDetailsTitleLabel)
        configTaskDetailsTitleLabel()
        
        view.addSubview(doneButton)
        configDoneButton()
        
        view.addSubview(stackView)
        configStackView()
        
    }
    
    private func configTaskDetailsTitleLabel() {
        NSLayoutConstraint.activate([
            taskDetailsTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            taskDetailsTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5),
            taskDetailsTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 5),
            taskDetailsTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: taskDetailsTitleLabel.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -15)
        ])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(taskTitleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(taskDescriptionTextView)
        configTitleLabel()
        configTaskTitleLabel()
        configDescriptionLabel()
        configTaskDescriptionTextView()
    }
    
    private func configTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configTaskTitleLabel() {
        NSLayoutConstraint.activate([
            taskTitleLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configDescriptionLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configDoneButton() {
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15),
            doneButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            doneButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -15),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configTaskDescriptionTextView() {
        NSLayoutConstraint.activate([
            taskDescriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
    }
    
    @objc private func editTask() {
        let editTaskViewController = EditTaskViewController()
        editTaskViewController.task = task
        editTaskViewController.delegate = self
        
        if let _ = navigationController {
            navigationController?.pushViewController(editTaskViewController, animated: true)
        } else {
            present(editTaskViewController, animated: true)
        }
    }
    
    @objc private func completeTask() {
        if var saveTask = task {
            saveTask.completed = true
            ManagedObjectContext.shared.update(task: saveTask) { _ in
                delegate?.loadData()
                navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension TaskDetailsViewController: ViewActionsDelegate {
    func setNewTask(_ task: Task) {
        self.task = task
    }
    
    func completeAction(actionType: ViewActions) {
        switch actionType {
        case .delete:
            delegate?.loadData()
            navigationController?.popViewController(animated: true)
            navigationController?.popViewController(animated: true)
        case .save:
            delegate?.loadData()
        case .dismiss:
            break
        }
    }
    

}
