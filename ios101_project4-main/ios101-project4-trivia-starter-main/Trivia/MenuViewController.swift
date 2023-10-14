//
//  MenuViewController.swift
//  Trivia
//
//  Created by libraries on 10/12/23.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var numberOfQuestions: UIButton!
    @IBOutlet weak var questionCategory: UIButton!
    @IBOutlet weak var questionDifficulty: UIButton!
    @IBOutlet weak var questionType: UIButton!
    @IBOutlet weak var back: UIButton!

    let numberOfQuestionsData = ["5","6","7","8","9","10"]
    let questionCategoryData = ["Any Difficutly","General Knowlegde", "Entertainment: Books", "Entertainment: Film",
                         "Entertainment: Music", "Entertainment: Musicals & Theathers","Entertainment: Comics",
                         "Entertainment: Television","Entertainment: Video Games","Entertainment: Board Games",
                         "Entertainment: Japanese Anime & Manga", "Entertainment: Cartoon & Animation",
                         "Science & Nature", "Science: Computer", "Science: Mathematics", "Mythology","Sports",
                         "Geography","History","Politics","Art","Celebrities","Animals","Vehicals","Science: Gadgets"]
    
    let questionDifficultyData = ["Any Difficulty", "Easy", "Medium", "Hard"]
    let questionTypeData = ["Multiple Choice", "True/False"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial text for buttons
        numberOfQuestions.setTitle(numberOfQuestionsData[0], for: .normal)
        questionCategory.setTitle(questionCategoryData[0], for: .normal)
        questionDifficulty.setTitle(questionDifficultyData[0], for: .normal)
        questionType.setTitle(questionTypeData[0], for: .normal)

        // Add target actions for button taps
        numberOfQuestions.addTarget(self, action: #selector(didTapDropdownButton1), for: .touchUpInside)
        questionCategory.addTarget(self, action: #selector(didTapDropdownButton2), for: .touchUpInside)
        questionDifficulty.addTarget(self, action: #selector(didTapDropdownButton3), for: .touchUpInside)
        questionType.addTarget(self, action: #selector(didTapDropdownButton4), for: .touchUpInside)
    }

    @objc func didTapDropdownButton1() {
        // Handle dropdownButton1 tap
    }

    @objc func didTapDropdownButton2() {
        // Handle dropdownButton2 tap
    }

    @objc func didTapDropdownButton3() {
        // Handle dropdownButton3 tap
    }

    @objc func didTapDropdownButton4() {
        // Handle dropdownButton4 tap
    }
    
    
}
// use unwind segue , access the titles on the buttons, pass them to the APIURLBUILDER, pass apiurl to the orginal viewcontroller (set some property non private on the orginal viewcontroller, needs to be a url), in og view controller, implement view did appear and refresh using the new url inside of view did appear

//
