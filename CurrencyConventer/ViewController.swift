//
//  ViewController.swift
//  CurrencyConventer
//
//  Created by Meltem Uğurlu on 16.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    
    //1)request&session
    //2)response&data
    //3)parsing&JSON serialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        let url = URL(string: "https://api.apilayer.com/fixer/latest?apikey=R33ywBWHWVx9b5oJ4R8ClESOXfOWsz4r")
        
        let session = URLSession.shared
        
        //Closure
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else{
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //async
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                //print(rates)
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                                
                            }
                        }
                        
                        
                    }catch{
                        print("error")
                    }
                
                    
                }
            }
        }
        
        task.resume()
        
    }
    
}

