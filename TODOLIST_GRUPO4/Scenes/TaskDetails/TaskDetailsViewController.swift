//
//  TaskDetailsViewController.swift
//  TODOLIST_GRUPO4
//
//  Created by Matheus Lenke on 27/03/22.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    
    var safeArea: UILayoutGuide!

    var task: Task? = nil
        
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
    
    lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Título da Task"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        textView.text = "Descrição da task"
        return textView
    }()

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide
        configUI()
        
        if let task = task {
            taskTitleLabel.text = task.title
            taskDescriptionTextView.text = task.description
        }
    }
    
    // MARK: UI Configurations
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(editTask))
        
        view.addSubview(taskDetailsTitleLabel)
        configTaskDetailsTitleLabel()
        
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
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15)
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
    
    private func configTaskDescriptionTextView() {
        NSLayoutConstraint.activate([
            taskDescriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
    }
    
    @objc private func editTask() {
        let editTaskViewController = EditTaskViewController()
        editTaskViewController.task = task
        
        self.present(editTaskViewController, animated: true)
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
