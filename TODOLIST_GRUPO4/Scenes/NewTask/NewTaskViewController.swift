//
//  NewTaskViewController.swift
//  TODOLIST_GRUPO4
//
//  Created by Matheus Lenke on 27/03/22.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    
    // MARK: Layout vars
    
    lazy var createNewTaskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Criar nova tarefa"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
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
    
    lazy var taskTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Título:"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Título da Task"
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição:"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.autocapitalizationType = .sentences
        textView.autocorrectionType = .default
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Descrição"
        return textView
    }()

    lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirmar", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmTaskCreation), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.setTitle("Cancelar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        safeArea = view.layoutMarginsGuide
        configUI()
    }
    
    // MARK: UI Configurations
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(createNewTaskTitleLabel)
        configCreateNewTaskTitleLabel()
        
        view.addSubview(buttonsStackView)
        configButtonsStackView()
        
        view.addSubview(stackView)
        configStackView()
    }
    
    private func configCreateNewTaskTitleLabel() {
        NSLayoutConstraint.activate([
            createNewTaskTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15),
            createNewTaskTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5),
            createNewTaskTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 5),
            createNewTaskTitleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: createNewTaskTitleLabel.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -15)
        ])
        
        stackView.addArrangedSubview(taskTitleLabel)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(taskDescriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        configTaskTitleLabel()
        configTitleTextField()
        configTaskDescriptionLabel()
        configDescriptionTextView()
    }
    
    private func configTaskTitleLabel() {
        NSLayoutConstraint.activate([
            taskTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configTitleTextField() {
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configTaskDescriptionLabel() {
        NSLayoutConstraint.activate([
            taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configDescriptionTextView() {
        NSLayoutConstraint.activate([
            descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
    }
    
    private func configButtonsStackView() {
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonsStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            buttonsStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
        
        buttonsStackView.addArrangedSubview(doneButton)
        buttonsStackView.addArrangedSubview(deleteButton)
//        configDoneButton()
//        configDeleteButton()
    }
    
    private func configDoneButton() {
        NSLayoutConstraint.activate([
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configDeleteButton() {
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Buttons actions

    @objc func closeModal() {
        dismiss(animated: true)
    }
    
    @objc func confirmTaskCreation() {
        // Função de salvar Task
        
        dismiss(animated: true)
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

extension NewTaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//             textView.text = nil
//             textView.textColor = UIColor.black
//         }
    }
}
