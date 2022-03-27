//
//  ViewController.swift
//  TODOLIST_GRUPO4
//
//  Created by SP11601 on 26/03/22.
//

import UIKit

class ViewController: UIViewController {

    var safeArea: UILayoutGuide!
    
    var tasks: [Task] = [] {
        didSet {
            DispatchQueue.main.async {
                self.toDosTableView.reloadData()
            }
        }
    }
    
    lazy var toDosTableView: UITableView! = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        safeArea = view.layoutMarginsGuide
        
        configUI()
        delegates()
        loadData()
    }
    
    private func configUI() {

        view.backgroundColor = .purple
        title = "TO DOs"
        
        let addButton = UIBarButtonItem(image: UIImage.init(systemName: "plus.square.on.square"), style: .plain, target: self, action: #selector(callNewTaskView))
        navigationItem.rightBarButtonItems = [addButton]

        configTableView()

    }
    
    private func configTableView() {
        view.addSubview(toDosTableView)
        NSLayoutConstraint.activate([
            toDosTableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            toDosTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            toDosTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -5),
            toDosTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        
        toDosTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
    }
    
    private func delegates() {
    
        toDosTableView.delegate = self
        toDosTableView.dataSource = self
        
    }
    
    private func loadData() {
        tasks = Task.getData()
    }
    
    @objc private func callNewTaskView() {
        let newTaskViewController = NewTaskViewController()
        
        navigationController?.present(newTaskViewController, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        let detailsVC = TaskDetailsViewController()
        detailsVC.task = task
        
        if let _ = navigationController {
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            present(detailsVC, animated: true)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    
    }
    
}
