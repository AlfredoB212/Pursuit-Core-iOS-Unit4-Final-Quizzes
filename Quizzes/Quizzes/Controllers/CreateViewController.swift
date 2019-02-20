//
//  CreateViewController.swift
//  Quizzes
//
//  Created by Alfredo Barragan on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate  {

    @IBOutlet weak var factTitleLabel: UITextField!
    @IBOutlet weak var factUno: UITextView!
    @IBOutlet weak var factDos: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factTitleLabel.delegate = self
        factUno.delegate = self
        factDos.delegate = self

       
    }
    
    
    @IBAction func cancelaPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createPressed(_ sender: UIBarButtonItem) {
        if factTitleLabel.text != ""  && factUno.text != "" && factDos.text != "" {
            let facts = [factUno.text!, factDos.text!]
            let timeStamp = Date.getISOTimestamp()
            let quizTitle = self.factTitleLabel.text!
            let id = UUID().uuidString
            let createdQuiz = SavedQuiz.init(id: id, quizTitle: quizTitle, facts: facts, savedAt: timeStamp)
            if let userName = UserDefaults.standard.object(forKey: UserDefaultsManager.profileNameKey) as? String{
                DataPersistenceModel.saveQuiz(userName: userName, quiz: createdQuiz)
                let alert = UIAlertController(title: "Quiz Saved To My Quizzes", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
            factUno.resignFirstResponder()
            factDos.resignFirstResponder()
            factUno.isEditable = false
            factDos.isEditable = false
            
        } else {
            let alert = UIAlertController(title: "Quiz requires a title and 2 facts", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
