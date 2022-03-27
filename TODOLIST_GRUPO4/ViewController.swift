//
//  ViewController.swift
//  TODOLIST_GRUPO4
//
//  Created by SP11601 on 26/03/22.
//

import UIKit

class ViewController: UIViewController {

    var safeArea: UILayoutGuide!
    
    lazy var toDosTableView: UITableView! = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var appearence: UINavigationBarAppearance! = {
        var appearence = UINavigationBarAppearance()
        
        appearence.shadowColor = .clear
        appearence.backgroundColor = .systemBackground
        appearence.titleTextAttributes = [.foregroundColor: UIColor.label]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        
        return appearence
    }()
    
    lazy var addButton: UIBarButtonItem! = {
        let button = UIBarButtonItem(image: UIImage.init(systemName: "plus.circle"), style: .plain, target: self, action: #selector(callNewTaskView))
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        safeArea = view.layoutMarginsGuide
        
        configUI()
        delegates()
        
    }
    
    private func configUI() {

        view.backgroundColor = .purple
        title = "TO DOs"

        configNavigationBar()
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
    
    private func configNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        navigationItem.rightBarButtonItem = addButton
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    
    }
    
}
