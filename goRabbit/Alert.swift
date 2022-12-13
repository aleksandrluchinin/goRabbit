//
//  Alert.swift
//  goRabbit
//
//  Created by Aleksandr  on 13.12.2022.
//

import UIKit

extension MapViewController {
    
    func alertAddadress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "Ок", style: .default) { (action) in
            
//            let tfText = alertController.textField?.first
//            guard let text = tfText?.text else { return }
//            completionHandler(text)
        }
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        
        let alertCansel = UIAlertAction(title: "Отмена", style: .default) { (_) in
            
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCansel)
        
        present(alertController, animated: true, completion: nil)
        
    }
    func alertError(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(alertOk)
        
        present(alertController, animated: true)
    }
}
