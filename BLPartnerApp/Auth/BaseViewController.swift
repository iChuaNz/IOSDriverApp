//
//  BaseViewController.swift
//  BLPartnerApp
//
//  Created by Arif Rahman Sidik on 15/08/24.
//

import UIKit
import Foundation

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    public func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc public func dismissContent() {
        self.dismiss(animated: true)
    }
    
    public func showBasicModal(title: String, message: String) {
        let vc = BasicModalViewController()
        vc.errorTittle = title
        vc.messageError = message
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    public func sendLocationData(latitude: Double, longitude: Double, altitude: Double, accuracy: Double, speed: Double, date: String) {
        guard let url = URL(string: "https://bustracker.azurewebsites.net/api/2/locations/gps") else {
            print("Invalid URL")
            return
        }

        // Prepare the request
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "token")

        // Prepare the request body
        let locationList: [[String: Any]] = [
            [
                "altitude": altitude,
                "speed": speed,
                "latitude": latitude,
                "longitude": longitude,
                "accuracy": accuracy,
                "datecreated": date
            ]
        ]

        // Convert the body to JSON data
        let body: [String: Any] = ["locationList": locationList]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        request.httpBody = jsonData

        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending request: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("Status code: \(httpResponse.statusCode)")

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }

        task.resume()
    }
}
