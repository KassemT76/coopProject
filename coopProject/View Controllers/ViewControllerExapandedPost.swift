//
//  ViewControllerExapandedPost.swift
//  coopProject
//
//  Created by CoopStudent on 8/2/22.
//

import UIKit

class ViewControllerExapandedPost: UIViewController {
    //Function to call apiCaller
    private let apiCaller = APICaller()
    private let v = ViewController()
    
    public var fetchdId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fetchdId ?? "No")
        setDataText()   
    }
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    

    public func setDataText(){
        
        apiCaller.fetchPostData(id: fetchdId ?? "Couldnt fetch id from vc1") { [self] result in
            
            switch result {
            case .success(let arr):
                print("View side", arr)
                self.titleText.text = arr[0]
                self.bodyText.text = arr[1]
        
            case .failure(_):
                print("Failed to fetch data")
                break
            }
        }
    }
  
}
