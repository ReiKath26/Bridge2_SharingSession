//
//  AddFormController.swift
//  ShoppingList_Bridge2Sharing
//
//  Created by Kathleen Febiola Susanto on 12/05/22.
//

import UIKit
import PhotosUI

class AddFormController: UIViewController, PHPickerViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    

    @IBOutlet var imagePick: UIImageView!
    @IBOutlet var pickImageButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var marketTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    var pickedImage: UIImage?
    var name: String = ""
    var price: Double = 0
    var marketSelected: Int = 0
    
    var editItem : Item?
    var pickerView = UIPickerView()
    var markets = [Market]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        marketData()
        fetchMarket()
        setPickerView()
        
        if editItem != nil
        {
            pickedImage = UIImage(data: (editItem?.picture!)!)
            imageChange()
            nameTextField.text = editItem?.name
            price = editItem?.price ?? 0
        }
        
        priceTextField.text = String(price)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapPickButton()
    {
        var photoConfig = PHPickerConfiguration()
        photoConfig.selectionLimit = 1
        photoConfig.filter = .images
        let vc = PHPickerViewController(configuration: photoConfig)
        vc.delegate = self
        present(vc, animated:  true)
    }
    
    func imageChange()
    {
        DispatchQueue.main.async {
            self.imagePick.image = self.pickedImage
        }
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let item = results.first?.itemProvider
        
        if let itemProvider = item, itemProvider.canLoadObject(ofClass: UIImage.self)
        {
            itemProvider.loadObject(ofClass: UIImage.self)
            {
                image, error in
                
                guard let images = image as? UIImage, error == nil else
                {
                    return
                }
                
                self.pickedImage = images
                self.imageChange()
                self.checkForm()
            }
        }
    }
    
    @IBAction func checkName()
    {
        name = nameTextField.text ?? ""
        checkForm()
    }
    
    @IBAction func stepperPrice(_ sender: UIStepper)
    {
        price = sender.value
        priceTextField.text = String(price)
        checkForm()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return markets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return markets[row].name
    }
    
    func marketData()
    {
        let market1 = Market(context: context)
        market1.name = "Alfamart"
        market1.distance = 0.2

        let market2 = Market(context: context)
        market2.name = "Indomaret"
        market2.distance = 0.4

        let market3 = Market(context: context)
        market3.name = "Lawson"
        market3.distance = 0.3

        let market4 = Market(context: context)
        market4.name = "7 Eleven"
        market4.distance = 1.2

        let market5 = Market(context: context)
        market5.name = "Aeon"
        market5.distance = 3.4
    }
    
    func fetchMarket()
    {
        do
        {
            markets = try context.fetch(Market.fetchRequest())
        }
        
        catch
        {
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        marketTextField.text = markets[row].name
        marketSelected = row
        checkForm()
    }
    
    func checkForm()
    {
        if pickedImage != nil && name != "" && price != 0 && marketSelected != 0
        {
            submitButton.isEnabled = true
        }
        
        else
        {
            submitButton.isEnabled = false
        }
    }
    
    func setPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        marketTextField.inputView = pickerView
        
        // default set value
        
        
        for x in 0..<markets.count
        {
            if markets[x].name == editItem?.market?.name
            {
                marketSelected = x
            }
        }
        
        if editItem != nil
        {
            pickerView.selectRow(marketSelected, inComponent: 0, animated: true)
            pickerView(pickerView, didSelectRow: marketSelected, inComponent: 0)
        }
        
        else
        {
            pickerView.selectRow(1, inComponent: 0, animated: true)
            pickerView(pickerView, didSelectRow: 1, inComponent: 0)
        }
        
       
        
    }
    
    @IBAction func tapSaveButton()
    {
        
        if editItem != nil
        {
            editItem?.name = name
            editItem?.price = price
            editItem?.picture = pickedImage?.jpegData(compressionQuality: 0.15)
            editItem?.market = markets[marketSelected]
        
        }
        
        else
        {
            let newItem = Item(context: context)
            newItem.name = name
            newItem.price = price
            newItem.picture = pickedImage?.jpegData(compressionQuality: 0.15)
            newItem.isBought = false
            newItem.market = markets[marketSelected]
        }
      
        
        do
        {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Succesfully saved item!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
        }
        
        catch
        {
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
