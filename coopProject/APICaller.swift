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
    @Published var list = [fdata]()
    
    public var isPaginating = false
    let db = Firestore.firestore()
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[fdata], Error>) -> Void){
        if pagination {
            isPaginating = true
        }
        
        db.collection("posts").getDocuments { snapshot, err in
            if err == nil{
                if let snapshot = snapshot {
                    self.list = snapshot.documents.map { d in
                        
                        return fdata(id: d.documentID, title: d["title"] as? String ?? "NA", body: d["body"] as? String ?? "NA")
                    }
                }
            }
            else {
                print("Err")
            }
        }
        print(list)
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let originalData = self.list
            let newData = self.list
            completion(.success(pagination ? newData :originalData))
            if pagination {
                self.isPaginating = false
            }
        })
    }
}
