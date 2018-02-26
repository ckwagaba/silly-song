//
//  ViewController.swift
//  SillySong
//
//  Created by CK Wagaba on 19/01/2018.
//  Copyright © 2018 Plus256. All rights reserved.
//

import UIKit

// returns short name from provided name
func shortNameFromName (name: String) -> String {
    var shortName = name.lowercased()
    shortName.remove(at: name.startIndex)
    
    /*
     recursively check if the first letter of the short name
     (which is the second letter of the full name) is a consonant
     and remove it
     */
    
    let vowels = ["a","e","i","o","u"]
    
    for letter in shortName {
        if vowels.contains(String(letter)) == false {
            // this is a consonant
            shortName.remove(at: shortName.startIndex)
        }
        else {
            // this is a vowel
            break
        }
    }
    
    return shortName
}

// returns lyrics from name
func lyricsForName (lyricsTemplate: String, fullName: String) -> String {
    // get the short name from the function
    let shortName = shortNameFromName(name: fullName)
    
    // replace with values of shortName and fullName
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {
    // doc string goes here
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: Any) {
        // clear out the text of the fields
        self.nameField.text = ""
        self.lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        // the lyrics template
        let bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
            "Banana Fana Fo F<SHORT_NAME>",
            "Me My Mo M<SHORT_NAME>",
            "<FULL_NAME>"].joined(separator: "\n")
        
        // name field should not be empty
        if !self.nameField.text!.isEmpty {
            self.lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: self.nameField.text!)
        }
        else {
            self.lyricsView.text = "Enter a name and try again."
        }
    }
    
}
