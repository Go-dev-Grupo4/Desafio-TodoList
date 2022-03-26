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
    
    
}
