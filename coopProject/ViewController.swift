//
//  ViewController.swift
//  coopProject
//
//  Created by CoopStudent on 7/31/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    //Function to call apiCaller
    private let apiCaller = APICaller()
    
    //Outlet for table
    @IBOutlet weak var tableView: UITableView!
    let cellSpacingHeight: CGFloat = 5
    
    //Data String
    private var data = [String]()
    
    //Loads Views
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    //Fetch data on load
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        apiCaller.fetchData(pagination: false, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
    
    //number of sections = number of data
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    //1 row per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int{
            return 1
        }
    
    //put a space in between each section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color see through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    //Put text in section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = data[indexPath.section]
            cell.detailTextLabel?.text = "Lorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsum"
            return cell
    }
    
    //Does Spinner when you are at the end
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView (frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    //Does Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("User Scrolling")
        
        let position = scrollView.contentOffset.y
        
        //Checks if you reach the end
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height){
            print("Fetching...")
            //Checks if you already reached end so you dont keep fetching data
            guard !apiCaller.isPaginating else {
                print("Still fetching...")
                return
            }
            //Create a spinner
            self.tableView.tableFooterView = createSpinnerFooter()
            
            apiCaller.fetchData(pagination: true) { [weak self] result in
                //Stop spin
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                //Results
                switch result {
                case .success(let moreData):
                    self?.data.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    print("Failed to fetch data")
                    break
                }
            }
        }
    }
    
    
}
