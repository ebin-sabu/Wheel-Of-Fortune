//
//  SecondViewController.swift
//  myAppWheel
//
//  Created by Ebin Pereppadan on 05/11/2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    var rewardRate = 0

    @IBOutlet weak var wheelSpinLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var wheelPic: UIImageView!
    @IBOutlet weak var InfoLabel: UILabel!
    
    
    // All contraints for each item used.
    func frame(){
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        TitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        TitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        wheelPic.translatesAutoresizingMaskIntoConstraints = false
        wheelPic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wheelPic.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wheelPic.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65).isActive = true
        wheelPic.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        wheelPic.contentMode = .scaleAspectFit
        
        wheelSpinLabel.translatesAutoresizingMaskIntoConstraints = false
        wheelSpinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wheelSpinLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wheelSpinLabel.textColor = .green
        wheelSpinLabel.textAlignment = .center

        
        InfoLabel.translatesAutoresizingMaskIntoConstraints = false
        InfoLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        InfoLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        InfoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        InfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wheelSpinLabel.text = "$\(rewardRate)"
        frame()

    }
}
