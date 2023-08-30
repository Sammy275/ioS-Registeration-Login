//
//  TemperatureViewController.swift
//  Register-And-Login
//
//  Created by Saim on 29/08/2023.
//

import UIKit

class CommentTableViewController: UIViewController {
    
    @IBOutlet var customTableView: UITableView!
    
    var commentList: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setupTableView()
        fetchTableData()
        print("Fetching finished")
    }
    
    func setupTableView() {
        customTableView.delegate = self
        customTableView.dataSource = self
    }
    
    func fetchTableData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        
        URLSession.shared.fetchData(at: url) { (result: Result<[Comment], Error>) in
            switch result {
            case .success(let dataList):
                self.commentList = dataList
                
                DispatchQueue.main.async {
                    self.customTableView.reloadData()
                }
                
                // Woo, we got our todo list
            case .failure(let error):
                print("Error")
                debugPrint(error)
                // Ohno, an error, let's handle it
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CommentDetailViewController
        destinationVC.commentDetail = sender as? Comment
    }
}


extension CommentTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = commentList[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedComment = commentList[indexPath.row]
        performSegue(withIdentifier: "ToCommentDetailVC", sender: selectedComment)
    }
    
    
}
