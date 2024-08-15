//
//  LoginViewController.swift
//  BLPartnerApp
//
//  Created by Arif Rahman Sidik on 19/07/24.
//

import UIKit


class LoginViewController: UIViewController {
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private let service = NetworkDataFetcher(service: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"
        self.submitButton.isEnabled = false
        phoneNumberTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        routeToPasscode()
    }
    
    func routeToPasscode() {
        let vc = PasscodeViewController()
        vc.phoneNumber = phoneNumberTF.text ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.submitButton.isEnabled = true
//        self.submitButton.tintColor = UIColor(hex: "FF8B26")
    }
}
