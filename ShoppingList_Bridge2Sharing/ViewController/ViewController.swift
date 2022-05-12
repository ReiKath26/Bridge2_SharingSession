//
//  ViewController.swift
//  ShoppingList_Bridge2Sharing
//
//  Created by Kathleen Febiola Susanto on 11/05/22.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate{
    

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
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchBar.showsCancelButton = true
//
//        if searchText == ""
//        {
//            fetchMarket()
//        }
//
//        else
//        {
//            var placeHolderMarket = [Market]()
//            markets = []
//
//            let fetchRequest = Market.fetchRequest()
//            let sort = NSSortDescriptor(key: "distance", ascending: true)
//
//            fetchRequest.sortDescriptors = [sort]
//
//            do
//            {
//                placeHolderMarket = try context.fetch(fetchRequest)
//
//                for x in 0..<placeHolderMarket.count
//                {
//                    if placeHolderMarket[x].itemArray?.contains(where: { item in
//                        item.name?.contains(searchText) == true
//                    }) == true
//                    {
//                        market.append(placeHolderMarket[x])
//                    }
//                }
//            }
//
//            catch
//            {
//
//            }
//        }
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        searchBar.endEditing(true)
//        fetchMarket()
//        searchBar.showsCancelButton = false
//    }
}

