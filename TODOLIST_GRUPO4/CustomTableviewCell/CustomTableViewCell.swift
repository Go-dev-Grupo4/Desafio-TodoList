//
//  CustomTableViewCell.swift
//  TODOLIST_GRUPO4
//
//  Created by SP11601 on 26/03/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "cell"
    
    lazy var toDoImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle"))
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var toDoStackView: UIStackView = {
        let stackview = UIStackView(frame: .zero)
        stackview.axis = .vertical
        stackview.spacing = 0
        stackview.distribution = .fillProportionally
        stackview.alignment = .top
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var toDoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TITULO"
        label.numberOfLines = 1
        return label
    }()

    lazy var toDoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA BLA "
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
        accessoryType = .disclosureIndicator
        
        configUI()
    }
    
    private func configUI() {
        ConfigToDoImage()
        ConfigToDoStackView()
    }
    
    private func ConfigToDoImage() {
        addSubview(toDoImage)
        NSLayoutConstraint.activate([
            toDoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            toDoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            toDoImage.heightAnchor.constraint(equalToConstant: 50),
            toDoImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func ConfigToDoStackView() {
        addSubview(toDoStackView)
        NSLayoutConstraint.activate([
            toDoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            toDoStackView.leadingAnchor.constraint(equalTo: toDoImage.trailingAnchor, constant: 10),
            toDoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            toDoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
        toDoStackView.addArrangedSubview(toDoTitleLabel)
        toDoStackView.addArrangedSubview(toDoDescriptionLabel)
        ConfigToDoTitleLabel()
    }
    
    private func ConfigToDoTitleLabel() {
        NSLayoutConstraint.activate([
            toDoTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .systemRed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
