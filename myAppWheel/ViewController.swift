//
//  ViewController.swift
//  WheelOfFortune
//
//  Created by Ebin Pereppadan on 04/11/2022.
//

import UIKit

// Global Variable used to decode json files
struct WordDetails : Codable {
    let genre : String
    let list : [String]
}


class ViewController: UIViewController, UICollectionViewDelegate,
                      UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //Initialising All Variables to some value
    var highScore1 : String!
    var genreName = ""
    let rewardRate = [1,2,5,10,20]
    var word = ""
    var wrongLettersArray = [Character]()
    var usedLetters = [Character]()
    var displayWordArray = [Character]()
    var displayWord = ""
    var counter = 0
    var score = 0
    var wheelSpin = 1
    var guess : Character!
    var spinDone: Bool = false
    
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    //CollectionView to display hidden character and then reveal them.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return word.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for:
        indexPath) as! myCVCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        //centerItemsInCollectionView(cellWidth: 30, numberOfItems: Double(word.count), spaceBetweenCell: 1.0 collectionView: collectionView)
        for _ in displayWordArray {
            let char = displayWordArray[indexPath.row]
            if char == "_" {
                cell.lettersImage.image = UIImage(named: "Blank")
                // if word contains a space/gap the collection view displays a blank white square.
            }
            else if char == "?" {
                cell.lettersImage.image = UIImage(named: "Hidden")
                // otherwise a blacked out square is shown
            }
            else{
                cell.lettersImage.image = UIImage(named: "\(char)")
                // if user has gussed correctly collection cell is set to correct character.
            }
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let theSize = CGSize(width: 30.0, height: 40.0)
        return theSize
    }

    // All outlets used in main game area
    @IBOutlet weak var GuessButtonOut: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var userGuess: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var wrongLettersTitle: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var wheelButton: UIButton!
    
    
    // When User presses guess button
    @IBAction func guessButton(_ sender: UIButton) {
        if spinDone == false {
            errorLabel.text = "Spin Wheel First"
        }
        else {
            let guess1 = userGuess.text
            if guess1 == "" {
                errorLabel.text = "Enter a Letter"
            }
            else if guess1!.count > 1{
                errorLabel.text = "One Letter Only"
            }
            else {
                //Guess is Accepted by Game
                guess = Character(userGuess.text!.capitalized)
                errorLabel.text = ""
                checkForLetter()
                displayWord = String(displayWordArray)
                userGuess.text = ""
                checkForWin()
            }
        }
    }
    
    // User Presses WheelSpin, Seque is performed to wheelspin popup
    @IBAction func rewardButton(_ sender: UIButton) {
        wheelSpin = rewardRate.randomElement()!
        spinDone = true
        wheelButton.isHidden = true
        userGuess.isHidden = false
        GuessButtonOut.isHidden = false
        performSegue(withIdentifier: "toWheel", sender: nil)
    }
    
    // Checks users guess with letters in the word/phrase
    func checkForLetter (){
        if usedLetters.contains(guess){
            if displayWordArray.contains(guess){
                errorLabel.text = "Already Guessed"
            }
            else{
                for i in 0...(word.count - 1) {
                    if guess == usedLetters[i] {
                        displayWordArray[i] = guess
                        counter += 1
                        //if letter guessed is correct add it to displaywordarray which then updates collection view
                    }
                }
                //increase score
                score += (counter * wheelSpin)
                scoreLabel.text = "Score: \(score)"
                counter = 0
                myCollection.reloadData()
                spinDone = false
                wheelButton.isHidden = false
                userGuess.isHidden = true
                GuessButtonOut.isHidden = true
            }
        }
        else if wrongLettersArray.contains(guess){
            errorLabel.text = "Already Guessed"
        }
        else {
            //when letter guessed is wrong add it to wrong letters array which is then displayed to user as a label.
            wrongLettersArray.append(guess)
            wrongLetters.text = String(wrongLettersArray)
        }
    }
    
    // check to see if user has revealed word/phrase/
    func checkForWin (){
        if wrongLettersArray.count == 10{
            // user has guessed letter incorrectly too many times and loss the game as well as their score.
            userGuess.isHidden = true
            GuessButtonOut.isHidden = true
            errorLabel.isHidden = true
            winLabel.text = "You Lost !"
            answerLabel.text = "The word was: \(word)"
        }
        else if displayWord.contains("?"){
            // does nothing as user has not finished revealing the word/phrase
        }
        else{
            //User has revealed all characters in word and has won the game.
            errorLabel.isHidden = true
            winLabel.text = "You Win !"
            wheelButton.isHidden = true
            userGuess.isHidden = true
            GuessButtonOut.isHidden = true
            // Checks to see if the have beaten any of the highscores.
            for i in 1...5 {
                let userDefaults = Foundation.UserDefaults.standard
                highScore1 = userDefaults.string(forKey: "HighScoreRecord\(i)")
                if highScore1 == nil {
                    let userDefaults = Foundation.UserDefaults.standard
                    userDefaults.set(String(score), forKey: "HighScoreRecord\(i)")
                    // if highscore field is empty automatically place score in highscores
                }
                else {
                        // if score is higher than highscore in any of the TOP 5 field update highscores.
                        let record:Int? = Int(highScore1)
                        if score > record! {
                            let userDefaults = Foundation.UserDefaults.standard
                            userDefaults.set(String(score), forKey: "HighScoreRecord\(i)")
                            score = record!
                        }
                }
            }
        }
    }
    
    //Resets the game allowing user to play again or start again.
    @IBAction func resetButton(_ sender: Any) {
        resetStart()
    }
    // Used to Start or reset the game.
    func resetStart () {
        errorLabel.text = ""
        wrongLettersArray = []
        wrongLetters.text = ""
        displayWord = ""
        winLabel.text = ""
        answerLabel.text = ""
        scoreLabel.text = "Score: 0"
        score = 0
        wheelButton.isHidden = false
        userGuess.isHidden = true
        GuessButtonOut.isHidden = true
        errorLabel.isHidden = false
        getWord()
        myCollection.reloadData()
    }
    
    //Randomly selects a word/phrase from chosen genre by user.
    func getWord(){
        guard let path = Bundle.main.path(forResource: genreName, ofType: "json")
            else{
                fatalError("Can't find JSON File")
        }
        guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: path), encoding: String.Encoding.utf8) else {
           return
        }
      var wordStuff : WordDetails?
               do {
                   wordStuff = try JSONDecoder().decode(WordDetails.self, from: Data(jsonString.utf8))
               } catch {
                   print("Decoding Failed")
               }
        word = (wordStuff?.list.randomElement()!)!
        word = word.uppercased()
        print(word)
        usedLetters = Array(word)
        
        //hides the word into an Array which is then used in collection view to calculate whether to reveal a character or not.
        for ch in word {
            if ch == " " {
                displayWord += "_"
            }
            else{
                displayWord += "?"
            }
            displayWordArray = Array(displayWord)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        frame()
        resetStart()
    }
    
    // Passing the wheelspin rate to popup so it can be desplayed to user.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWheel" {
            let viewControllerData = segue.destination as! SecondViewController
            viewControllerData.rewardRate = wheelSpin
        }
    }
    
    
    // Function that calculates the contratiants so app works in landscape and upright.
    func frame(){
        //split the main view into two one top and one bottom
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
        topContainerView.addSubview(myCollection)
        topContainerView.addSubview(scoreLabel)
        topContainerView.addSubview(ResetButton)
        topContainerView.addSubview(wheelButton)
        topContainerView.addSubview(GuessButtonOut)
        topContainerView.addSubview(userGuess)
        topContainerView.addSubview(winLabel)
        
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        TitleLabel.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.75).isActive = true
        TitleLabel.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.2).isActive = true
        
        myCollection.translatesAutoresizingMaskIntoConstraints = false
        myCollection.backgroundColor = .darkGray
        myCollection.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor).isActive = true
        myCollection.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        //myCollection.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        myCollection.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, constant: -10).isActive = true
        myCollection.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.70).isActive = true
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scoreLabel.leftAnchor.constraint(equalTo: topContainerView.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        scoreLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        ResetButton.translatesAutoresizingMaskIntoConstraints = false
        ResetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        ResetButton.rightAnchor.constraint(equalTo: topContainerView.safeAreaLayoutGuide.rightAnchor, constant: 5).isActive = true
        ResetButton.widthAnchor.constraint(equalToConstant: 85).isActive = true

        wheelButton.translatesAutoresizingMaskIntoConstraints = false
        wheelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wheelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wheelButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        wheelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        GuessButtonOut.translatesAutoresizingMaskIntoConstraints = false
        GuessButtonOut.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        GuessButtonOut.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        GuessButtonOut.heightAnchor.constraint(equalToConstant: 50).isActive = true
        GuessButtonOut.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        userGuess.translatesAutoresizingMaskIntoConstraints = false
        userGuess.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        userGuess.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        userGuess.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userGuess.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userGuess.backgroundColor = .white
        userGuess.textColor = .black
        userGuess.borderStyle = .roundedRect
        
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        winLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        winLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        //Bottom view
        let bottomContainerView = UIView()
        bottomContainerView.backgroundColor = .orange
        view.addSubview(bottomContainerView)
        bottomContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        bottomContainerView.addSubview(wheelButton)
        bottomContainerView.addSubview(GuessButtonOut)
        bottomContainerView.addSubview(userGuess)
        bottomContainerView.addSubview(winLabel)
        bottomContainerView.addSubview(wrongLettersTitle)
        bottomContainerView.addSubview(wrongLetters)
        bottomContainerView.addSubview(errorLabel)
        bottomContainerView.addSubview(answerLabel)
        
        wrongLettersTitle.translatesAutoresizingMaskIntoConstraints = false
        wrongLettersTitle.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
        wrongLettersTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        wrongLetters.translatesAutoresizingMaskIntoConstraints = false
        wrongLetters.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wrongLetters.topAnchor.constraint(equalTo: wrongLettersTitle.bottomAnchor, constant: 10).isActive = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 30).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 30).isActive = true
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

