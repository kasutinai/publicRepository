//
//  CarViewController.swift
//  CarsList
//
//  Created by Андрей Касутин on 20/05/2019.
//  Copyright © 2019 Андрей Касутин. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    var car: Cars?
    
    @IBOutlet weak var modelText: UITextField!
    @IBOutlet weak var klassText: UITextField!
    @IBOutlet weak var producerText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    @IBAction func save(_ sender: Any) {
        if saveCar() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let car = car {
            modelText.text = car.model
            klassText.text = car.klass
            producerText.text = car.producer
            typeText.text = car.type
            yearText.text = String(car.year)
        }

        // Do any additional setup after loading the view.
    }
    
    func saveCar() -> Bool {
        // Validation of required fields
        if modelText.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка", message: "Введите название модели", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        // Creating object
        if car == nil {
            car = Cars()
        }
        // Saving object
        if let car = car {
            car.model = modelText.text
            car.klass = klassText.text
            car.producer = producerText.text
            car.type = typeText.text
            if let year = Int16(yearText.text ?? ""){
                car.year = year
            }
            else {
                let alert = UIAlertController(title: "Ошибка", message: "Введите год выпуска", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            
            AppDelegate.instance.saveContext()
        }
        return true
    }
}
