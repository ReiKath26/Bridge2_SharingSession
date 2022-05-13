//
//  ViewController.swift
//  ShoppingList_Bridge2Sharing
//
//  Created by Kathleen Febiola Susanto on 11/05/22.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var markets = [Market]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.navigationController?.navigationBar.tintColor = UIColor.systemGreen
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "item_cell")
        fetchMarket()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMarket()
    }
    
    
    @objc func addItem()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddForm") as! AddFormController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item_cell", for: indexPath) as! TableViewCell
        cell.itemName.text = markets[indexPath.section].itemArray[indexPath.row].name
        
        let price: Double = markets[indexPath.section].itemArray[indexPath.row].price
        
        cell.itemPrice.text = "Rp. \(price)"
        
        cell.thumbnailImage.image = UIImage(data: markets[indexPath.section].itemArray[indexPath.row].picture!)
        
        cell.checkImage.image = markets[indexPath.section].itemArray[indexPath.row].isBought ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markets[section].items?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if markets[section].itemArray.isEmpty
        {
            return nil
        }
        
        else
        {
            return markets[section].name
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddForm") as! AddFormController
            vc.editItem = self.markets[indexPath.section].itemArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                
                let deleteObject = self.markets[indexPath.section].itemArray[indexPath.row]
                self.context.delete(deleteObject)
                
                do
                {
                    try self.context.save()
                    self.fetchMarket()
                }
                
                catch
                {
                    
                }
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
                alert.dismiss(animated: true)
            }))
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    //kalau tableviewnya di swipe, edit -> dibawa ke form addnya tadi lagi tpi kita bawa data dari item
    //yang diselect ke si add form, delete -> keluarin alert -> pencet yes nanti itemnya bakal kehapus
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        markets[indexPath.section].itemArray[indexPath.row].isBought.toggle()
        
        do
        {
            try context.save()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        catch
        {
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return markets.count
    }
    
    func fetchMarket()
    {
        do
        {
            markets = try context.fetch(Market.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        catch
        {
            
        }
        
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

