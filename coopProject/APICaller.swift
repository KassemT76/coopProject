//
//  APICaller.swift
//  coopProject
//
//  Created by CoopStudent on 7/31/22.
//

import Foundation

class APICaller{
    public var isPaginating = false
    
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[String], Error>) -> Void){
        if pagination {
            isPaginating = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let originalData = [
            "Kassem",
            "Hiba",
            "Abood",
            "Hamood",
            "Jana",
            "Mousse",
            "Kassem",
            "Hiba",
            "Abood",
            "Hamood",
            "Jana",
            "Mousse",
            "Kassem",
            "Hiba",
            "Abood",
            "Hamood",
            "Jana",
            "Mousse",
            "Kassem",
            "Hiba",
            "Abood",
            "Hamood",
            "Jana",
            "Mousse"
            ]
            let newData = [
            "fruits", "cool", "choclate"
            ]
            completion(.success(pagination ? newData :originalData))
            if pagination {
                self.isPaginating = false
            }
        })
    }
}
