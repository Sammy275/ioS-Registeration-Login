//
//  CommentDetailViewController.swift
//  Register-And-Login
//
//  Created by Saim on 30/08/2023.
//

import UIKit

class CommentDetailViewController: UIViewController {
    
    @IBOutlet var postIdLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    
    var commentDetail: Comment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    func setLabels() {
        postIdLabel.text = "Post Id: \(commentDetail!.postId)"
        idLabel.text = "Id: \(commentDetail!.id)"
        emailLabel.text = "Email: \(commentDetail!.email)"
        nameLabel.text = "Name: \(commentDetail!.name)"
        
        bodyLabel.text = commentDetail!.body
    }
}
