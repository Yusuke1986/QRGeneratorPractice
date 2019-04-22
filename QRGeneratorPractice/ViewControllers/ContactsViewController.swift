//
//  ContactsViewController.swift
//  QRGeneratorPractice
//
//  Created by 松岡裕介 on 2019/04/19.
//  Copyright © 2019 松岡裕介. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var navBar = UINavigationBar()
    var tableView: UITableView?
    var people = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view = UIView()
        view.backgroundColor = .white

        let navItem: UINavigationItem = UINavigationItem(title: "Contacts")
        navBar.pushItem(navItem, animated: false)
        view.addSubview(navBar)
        
        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
            tableView.autoresizingMask = [
                .flexibleWidth,
                .flexibleHeight
            ]

            tableView.delegate = self
            tableView.dataSource = self

            self.view.addSubview(tableView)

            return tableView
        }()
        
        let store = CNContactStore.init()
        //var customPeople = [CNContact]()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactEmailAddressesKey,
            CNContactPhoneNumbersKey,
            CNContactPostalAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        do {
            try store.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])) {(contact, cursor) -> Void in
                
                if (!contact.phoneNumbers.isEmpty) {
                    self.people.append(contact)
                }
            }
        }
        catch{
            print("error")
        }
        
        
        loadConstraints()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if people.count > 0 {
            emptyMessage(message: "", tableView: self.tableView!)
            return 1
        } else {
            emptyMessage(message: """
        Please
        add
        new
        TO DO
        """, tableView: self.tableView!)
            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")

        cell.textLabel?.text = "\(people[indexPath.row].givenName) \(people[indexPath.row].familyName)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let nextvc = QRViewController()

        nextvc.items = self.people[indexPath.row]
        self.present(nextvc, animated: true, completion: nil)
    }

    func emptyMessage(message:String, tableView: UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 48)
        messageLabel.sizeToFit()

        tableView.backgroundView = messageLabel
        tableView.separatorStyle = .none
    }
    
    func loadConstraints() {
        
        let tableView = self.tableView!
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 80)
            ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

//class ContactsViewController: UIViewController, CNContactPickerDelegate {
//
//    var items = ContactInfo()
//    var picker: CNContactPickerViewController?
//    var ck = true
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        picker = CNContactPickerViewController()
//        picker!.delegate = self
//
//        ck = true
//        // Show the picker
//        //self.present(picker, animated: true, completion: nil)
//        //ck = true
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if ck == true {
//            self.present(picker!, animated: true, completion: nil)
//        }
//    }
//
//
//
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
//
//        let nextvc = QRViewController()
//        items.contactName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
//
//        nextvc.items = self.items
//        picker.dismiss(animated: false, completion: nil)
//        //self.dismiss(animated: false, completion: nil)
//
//        self.present(nextvc, animated: true, completion: nil)
//        ck = false
//    }
//}
