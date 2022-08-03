//
//  APICaller.swift
//  coopProject
//
//  Created by CoopStudent on 7/31/22.
//

import Foundation
import Firebase
import FirebaseFirestore

class APICaller: ObservableObject{
    //takes the data model from fdata.swift
    @Published var list = [fdata]()
    //public var for operations in view controller
    public var isPaginating = false
    
    //original code lets gooooooo
    func fetchPostData(id: String, completion: @escaping (Result<[String], Error>) -> Void){
        //reference to database
        let db = Firestore.firestore()
        print("id is", id)
        let docRef = db.collection("posts").document(id)
        var arr = [String]()
        docRef.getDocument(source: .cache) { (document, error) in
                    if let document = document {
                        let title = document.get("title") as! String
                        let body = document.get("body") as! String
                        arr = [title, body]
                        completion(.success(arr))
                    } else {
                        print("Document does not exist in cache")
                    }
                }
        
    }
    
    func addData(title: String, body: String){
        //reference to database
        let db = Firestore.firestore()
        
        db.collection("posts").addDocument(data: ["title":title, "body":body]) { error in
            if error == nil {
                //do stuff
                print("sucess")
            }
            else {
                print("err")
            }
        }
        
        
    }
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[fdata], Error>) -> Void){
        //reference to database
        let db = Firestore.firestore()
        
        if pagination {
            isPaginating = true
        }
        
        //gets documents within collection 'posts'
        db.collection("posts").getDocuments { snapshot, err in
            //error check
            if err == nil{
                //snapshot is basically results
                if let snapshot = snapshot {
                    //maps to return value
                    self.list = snapshot.documents.map { d in
                        //returns values as fdata data model
                        return fdata(id: d.documentID, title: d["title"] as? String ?? "NA", body: d["body"] as? String ?? "NA")
                    }
                }
            }
            else {
                print("Err")
            }
        }
        //If there is pagination wait 3 secs, otherwise wait 2 then executes the transfer between this class and the view controller
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let originalData = self.list
            let newData = self.list
            completion(.success(pagination ? newData :originalData)) //if pagination is true it will cycle through the new data, otherwise it will pick original data
            //set pagination to false as we are done fetching data and we can continue scrolling if we reached the end again
            if pagination {
                self.isPaginating = false
            }
        })
    }
    
}
