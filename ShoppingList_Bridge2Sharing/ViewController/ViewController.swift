//
//  ViewController.swift
//  ShoppingList_Bridge2Sharing
//
//  Created by Kathleen Febiola Susanto on 11/05/22.
//

import UIKit

class ViewController: UIViewController{
    
    //Versi Ready

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
    
        // Do any additional setup after loading the view.
    }
    
    
    @objc func addItem()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddForm") as! AddFormController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

