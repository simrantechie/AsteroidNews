//
//  AsteroidsListCell.swift
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 24/12/21.
//

import UIKit

class AsteroidsListCell: UITableViewCell {

    //MARK:- Variables
    var backView: UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1.0).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var asteroidName: UILabel = {
        var name = UILabel()
        name.textColor = .white
        name.font = UIFont(name: "Kefa-Regular", size: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    var viewDetailsBtn: UIButton = {
        var button = UIButton()
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 15
        button.setTitle("View Details", for: .normal)
        button.titleLabel?.font = UIFont(name: "Kefa-Regular", size: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK:- Layout Views
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        asteroidName.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10).isActive = true
        asteroidName.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10).isActive = true
        asteroidName.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10).isActive = true
        
        viewDetailsBtn.topAnchor.constraint(equalTo: asteroidName.bottomAnchor, constant: 0).isActive = true
        viewDetailsBtn.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10).isActive = true
        viewDetailsBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewDetailsBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewDetailsBtn.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10).isActive = true
    }
}
