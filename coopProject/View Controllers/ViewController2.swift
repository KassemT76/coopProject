//
//  ViewController2.swift
//  coopProject
//
//  Created by CoopStudent on 7/31/22.
//

import UIKit
import Firebase
import FirebaseFirestore


class ViewController2: UIViewController {
    
    private let apiCaller = APICaller()
    
    @IBOutlet weak var titleTextIn: UITextField!
    @IBOutlet weak var bodyTextIn: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBAction func addPost(_ sender: Any) {
        apiCaller.addData(title: titleTextIn.text ?? "", body: bodyTextIn.text ?? "")
    }
}

