//
//  ViewController.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import UIKit

class TriviaViewController: UIViewController {
  
  @IBOutlet weak var currentQuestionNumberLabel: UILabel!
  @IBOutlet weak var questionContainerView: UIView!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var answerButton0: UIButton!
  @IBOutlet weak var answerButton1: UIButton!
  @IBOutlet weak var answerButton2: UIButton!
  @IBOutlet weak var answerButton3: UIButton!
  @IBOutlet weak var resetButton: UIButton!
  
  private var questions = [TriviaQuestion]()
  private var currQuestionIndex = 0
  private var numCorrectQuestions = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGradient()
    questionContainerView.layer.cornerRadius = 8.0
    // TODO: FETCH TRIVIA QUESTIONS HERE
      try! fetchTriviaQuestions()
      
      resetButton.addTarget(self, action: #selector(didTapResetButton(_:)), for: .touchUpInside)

  }
  
  private func fetchTriviaQuestions() throws {
      // lines 35 -37 executed
      guard let url = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple") else {
          throw URLError(.badURL)
      }
      // URLRequest is created
      // closure starting on open curly is then created
      // closure and the URLRequest are then passed to the datatask method
      // finally resume is called on the data task
      URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
          guard let data = data else {
              print(error?.localizedDescription ?? "NO DATA AND NO ERROR")
              return
          }
          
          try! self?.questions = JSONDecoder().decode(TriviaQuestionResponse.self, from: data).results
          // WARNING: DONT HAVE BACKGROUND THREADS AFFECTING THE UI
          // PASSING CLOSURE TO THE MAIN THREAD
          DispatchQueue.main.async {
              // WRAPPING A UI API CALL IN CLOSURE
              self?.updateQuestion(withQuestionIndex: 0)
          }
          
          
      }.resume()
  }


    @objc private func didTapResetButton(_ sender: UIButton) {
        resetGame()
    }

    private func resetGame() {
        // Reset the game state
        currQuestionIndex = 0
        numCorrectQuestions = 0

        // Fetch new trivia questions
        try! fetchTriviaQuestions()

        // Update the UI with the first question
        updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    
    
  private func updateQuestion(withQuestionIndex questionIndex: Int) {
      currentQuestionNumberLabel.text = "Question: \(questionIndex + 1)/\(questions.count)"
    let question = questions[questionIndex]
    questionLabel.text = question.question.htmlDecoded
    categoryLabel.text = question.category
      let answers = ([question.correctAnswer] + question.incorrectAnswers).shuffled()
    if answers.count > 0 {
        answerButton0.setTitle(answers[0].htmlDecoded, for: .normal)
    }
    if answers.count > 1 {
      answerButton1.setTitle(answers[1].htmlDecoded, for: .normal)
      answerButton1.isHidden = false
    }
    if answers.count > 2 {
        answerButton2.setTitle(answers[2].htmlDecoded, for: .normal)
      answerButton2.isHidden = false
    }
    if answers.count > 3 {
        answerButton3.setTitle(answers[3].htmlDecoded, for: .normal)
      answerButton3.isHidden = false
    }
  }
  
  private func updateToNextQuestion(answer: String) {
    if isCorrectAnswer(answer) {
      numCorrectQuestions += 1
    }
    currQuestionIndex += 1
    guard currQuestionIndex < questions.count else {
      showFinalScore()
      return
    }
    updateQuestion(withQuestionIndex: currQuestionIndex)
  }
  
  private func isCorrectAnswer(_ answer: String) -> Bool {
    return answer == questions[currQuestionIndex].correctAnswer
  }
  
  private func showFinalScore() {
    let alertController = UIAlertController(title: "Game over!",
                                            message: "Final score: \(numCorrectQuestions)/\(questions.count)",
                                            preferredStyle: .alert)
    let resetAction = UIAlertAction(title: "Restart", style: .default) { [unowned self] _ in
        self.currQuestionIndex = 0
        self.numCorrectQuestions = 0
        self.updateQuestion(withQuestionIndex: currQuestionIndex)
    }
    alertController.addAction(resetAction)
    present(alertController, animated: true, completion: nil)
      
      
  }
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [UIColor(red: 0.54, green: 0.88, blue: 0.99, alpha: 1.00).cgColor,
                            UIColor(red: 0.51, green: 0.81, blue: 0.97, alpha: 1.00).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
  }
  
  @IBAction func didTapAnswerButton0(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton1(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton2(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
  
  @IBAction func didTapAnswerButton3(_ sender: UIButton) {
    updateToNextQuestion(answer: sender.titleLabel?.text ?? "")
  }
}

extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return self }
        return attributedString.string
    }
}
