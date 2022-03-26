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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
    }
    
    private func configUI() {
        
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
