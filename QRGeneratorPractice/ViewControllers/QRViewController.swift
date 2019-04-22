//
//  QRViewController.swift
//  QRGeneratorPractice
//
//  Created by 松岡裕介 on 2019/04/19.
//  Copyright © 2019 松岡裕介. All rights reserved.
//

import UIKit
import ContactsUI




class QRViewController: UIViewController {

    var navBar = UINavigationBar()
    
    var qrCodeImage = UIImageView()
    
    var lblName = UILabel()
    var lblPhone = UILabel()
    var lblEmail = UILabel()
    var lblAddress = UILabel()
    
    var txtName = UITextField()
    var txtPhone = UITextField()
    var txtEmail = UITextField()
    var txtAddress = UITextField()
    
    var items: CNContact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = UIView()
        view.backgroundColor = .white
        
        //navItem
        let navItem: UINavigationItem = UINavigationItem(title: "QRCode")
                navItem.leftBarButtonItem = UIBarButtonItem(title: "< BACK", style: .plain, target: self, action: #selector(self.returnView))
                navBar.pushItem(navItem, animated: false)
        
                navBar.translatesAutoresizingMaskIntoConstraints = false
                view.addConstraints([
                    navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
                    navBar.heightAnchor.constraint(equalToConstant: 80)
                    ])
                view.addSubview(navBar)
        
        //UILabel
        lblName.text = "Name:"
        lblPhone.text = "Phone:"
        lblEmail.text = "Email:"
        lblAddress.text = "Address:"
        
        //UITextField
        txtName.borderStyle = .roundedRect
        txtPhone.borderStyle = .roundedRect
        txtEmail.borderStyle = .roundedRect
        txtAddress.borderStyle = .roundedRect
        
        txtName.text = "\(items!.givenName) \(items!.familyName)"
        
        let phoneNumbers = items!.phoneNumbers
        for phoneNumber in phoneNumbers {
            if let phoneText = (phoneNumber.value as CNPhoneNumber?)?.stringValue {
                txtPhone.text = phoneText
            }
        }
        
        let emailAddresses = items!.emailAddresses
        for emailAddress in emailAddresses {
            if let emailText = emailAddress.value as String? {
                txtEmail.text = emailText
            }
        }
        
        let addresses = items!.postalAddresses
        for address in addresses {
            if let addressText = address.value.street as String? {
                txtAddress.text = addressText
            }
        }

        txtName.isEnabled = false
        txtPhone.isEnabled = false
        txtEmail.isEnabled = false
        txtAddress.isEnabled = false
        
        //constraints
        loadConstraints()
        
        
        view.addSubview(lblName)
        view.addSubview(lblPhone)
        view.addSubview(lblEmail)
        view.addSubview(lblAddress)
        view.addSubview(txtName)
        view.addSubview(txtPhone)
        view.addSubview(txtEmail)
        view.addSubview(txtAddress)
  
        if items != nil {
            //let csv = "\(txtName.text!),\(txtPhone.text!),\(txtEmail.text!),\(txtAddress.text!)"
            let csv = "MECARD:N:\(txtName.text!);TEL:\(txtPhone.text!);EMAIL:\(txtEmail.text!);ADDRESS:\(txtAddress.text!);;"
            
            let data = csv.data(using: String.Encoding.utf8)!
            let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data,"inputCorrectionLevel": "M"])!
            let sizeTransform = CGAffineTransform(scaleX: 7, y: 7)
            let qrImage = qr.outputImage!.transformed(by: sizeTransform)
            qrCodeImage.image = UIImage(ciImage: qrImage)
            qrCodeImage.contentMode = .scaleAspectFit
            //qrCodeImage.frame = self.view.frame
            view.addSubview(qrCodeImage)
        }
    }
    

    func loadConstraints() {
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        qrCodeImage.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            qrCodeImage.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10),
            qrCodeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            qrCodeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50.0)
            ])
        
        lblName.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            lblName.topAnchor.constraint(equalTo: qrCodeImage.bottomAnchor, constant: 20.0),
            lblName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            lblName.widthAnchor.constraint(equalToConstant: 100),
            lblName.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        lblPhone.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            lblPhone.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 20.0),
            lblPhone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            lblPhone.widthAnchor.constraint(equalToConstant: 100),
            lblPhone.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        lblEmail.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            lblEmail.topAnchor.constraint(equalTo: lblPhone.bottomAnchor, constant: 20.0),
            lblEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            lblEmail.widthAnchor.constraint(equalToConstant: 100),
            lblEmail.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            lblAddress.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 20.0),
            lblAddress.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            lblAddress.widthAnchor.constraint(equalToConstant: 100),
            lblAddress.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        txtName.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            txtName.topAnchor.constraint(equalTo: qrCodeImage.bottomAnchor, constant: 20.0),
            txtName.leadingAnchor.constraint(equalTo: lblName.trailingAnchor, constant: 20.0),
            txtName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            txtName.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        txtPhone.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            txtPhone.topAnchor.constraint(equalTo: txtName.bottomAnchor, constant: 20.0),
            txtPhone.leadingAnchor.constraint(equalTo: txtName.leadingAnchor),
            txtPhone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            txtPhone.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        txtEmail.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            txtEmail.topAnchor.constraint(equalTo: txtPhone.bottomAnchor, constant: 20.0),
            txtEmail.leadingAnchor.constraint(equalTo: txtPhone.leadingAnchor),
            txtEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            txtEmail.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        txtAddress.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            txtAddress.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: 20.0),
            txtAddress.leadingAnchor.constraint(equalTo: txtEmail.leadingAnchor),
            txtAddress.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            txtAddress.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
        @objc func returnView() {
    
            //let nextvc = ContactsViewController()
            //nextvc.ck = false
            self.dismiss(animated: false, completion: nil)
            
        }
}
