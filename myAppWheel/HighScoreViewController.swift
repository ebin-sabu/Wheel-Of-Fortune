//
//  HighScoreViewController.swift
//  myAppWheel
//
//  Created by Ebin Pereppadan on 13/11/2022.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var HighScoreTable: UITableView!
    
    // Displays A table containing the top 5 highscores.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableCell", for: indexPath)
        var content = UIListContentConfiguration.cell()
            let userDefaults = Foundation.UserDefaults.standard
            let highScore = userDefaults.string(forKey: "HighScoreRecord\(indexPath.row + 1)")
            if highScore == nil{
                content.text = "No. \(indexPath.row+1) Place: 0"
            }
            else{
                content.text = "No. \(indexPath.row+1) Place: \(highScore ?? "0")"
            }
        
        cell.contentConfiguration = content
        cell.backgroundColor = .orange
        cell.tintColor = .tintColor
        return cell
    }

    override func viewDidLoad() {
        view.backgroundColor = .orange
        HighScoreTable.backgroundColor = .orange
        super.viewDidLoad()
    }

}
