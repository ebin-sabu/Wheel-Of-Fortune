//
//  IntroViewController.swift
//  myAppWheel
//
//  Created by Ebin Pereppadan on 10/11/2022.
//

import UIKit

class IntroViewController: UIViewController {
    var selectedGenre = ""
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var Button1: UIButton!
    
    @IBOutlet weak var Button2: UIButton!
    
    @IBOutlet weak var Button3: UIButton!
    
    @IBOutlet weak var HighScoreButton: UIButton!
    
    
    @IBOutlet weak var wheelPic: UIImageView!
    
    // HighScore button gets clicked to take you to high scores page.
    @IBAction func HighScoreButton(_ sender: Any) {
        performSegue(withIdentifier: "toHighscore", sender: nil)
    }
    //The button selected is made the genre which then is used to find the phrase from json file.
    @IBAction func MovieButton(_ sender: Any) {
        selectedGenre = "Classic Movies"
        performSegue(withIdentifier: "toGame", sender: nil)
    }
    
    @IBAction func BookButton(_ sender: Any) {
        
        selectedGenre = "Classic Books"
        performSegue(withIdentifier: "toGame", sender: nil)
    }
    @IBAction func TVButton(_ sender: Any) {
        selectedGenre = "TV Shows"
        performSegue(withIdentifier: "toGame", sender: nil)
    }
    
    //Frame constraints to make app work in both portrait and landscap
    func FrameDesign (){
        let topContainerView = UIView()
        topContainerView.backgroundColor = .darkGray
        view.addSubview(topContainerView)
        topContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topContainerView.addSubview(TitleLabel)
        topContainerView.addSubview(Button1)
        topContainerView.addSubview(Button2)
        topContainerView.addSubview(wheelPic)
        
        let bottomContainerView = UIView()
        bottomContainerView.backgroundColor = .orange
        view.addSubview(bottomContainerView)
        bottomContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        bottomContainerView.addSubview(Button1)
        bottomContainerView.addSubview(Button3)
        bottomContainerView.addSubview(HighScoreButton)
        
        Button1.translatesAutoresizingMaskIntoConstraints = false
        Button1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button1.centerYAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        Button1.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.55).isActive = true
        Button1.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.225).isActive = true
        
        Button2.translatesAutoresizingMaskIntoConstraints = false
        Button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button2.bottomAnchor.constraint(equalTo: Button1.topAnchor, constant: -15).isActive = true
        Button2.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 0.55).isActive = true
        Button2.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.225).isActive = true
        
        Button3.translatesAutoresizingMaskIntoConstraints = false
        Button3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Button3.topAnchor.constraint(equalTo: Button1.bottomAnchor, constant: 15).isActive = true
        Button3.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 0.55).isActive = true
        Button3.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.225).isActive = true
        
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        TitleLabel.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.75).isActive = true
        TitleLabel.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.2).isActive = true
        
        HighScoreButton.translatesAutoresizingMaskIntoConstraints = false
        HighScoreButton.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.135).isActive = true
        HighScoreButton.widthAnchor.constraint(equalToConstant: 108).isActive = true
        HighScoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        HighScoreButton.topAnchor.constraint(equalTo: Button3.bottomAnchor, constant: 20).isActive = true
        
        wheelPic.translatesAutoresizingMaskIntoConstraints = false
        wheelPic.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.2).isActive = true
        wheelPic.widthAnchor.constraint(equalToConstant: 150).isActive = true
        wheelPic.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wheelPic.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 1).isActive = true
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        FrameDesign()
        // Do any additional setup after loading the view
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            let viewControllerData = segue.destination as! ViewController
            viewControllerData.genreName = selectedGenre
        
        }
    }

}
