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
    let db = Firestore.firestore()
    
    @IBAction func frat(_ sender: Any) {
        getData()
        print("pressed")
    }
    @IBOutlet weak var butt: UIButton!
func getData(){
   db.collection("test").getDocuments { snapshot, err in
       if err == nil{
           if let snapshot = snapshot {
               snapshot.documents.map { d  -> String in
               let id = d.documentID
               let one = d["name"] as? String
               let two = d["email"] as? String
               let three = d["password"] as? String
               
               print(id, one, two, three)
                   
                   return one ?? ""
               }
           }
       }
       else {
           print("Err")
       }
   }
}
}