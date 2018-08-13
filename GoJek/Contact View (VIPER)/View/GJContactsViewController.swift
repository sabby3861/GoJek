//
//  GJContactsViewController.swift
//  GoJek
//
//  Created by sanjay on 11/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

class GJContactsViewController: UIViewController, GJContactsViewProtocol {
  var presenter: GJContactsPresenterProtocol?
  var contacts: [GJContactInfo]! = nil
  
  @IBOutlet weak var tableView: GJTableView!
  var contactsDictionary = [String: [GJContactInfo]]()
  var contactsSectionTitles = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.formatGetPayload()
    self.presenter?.fetchContactsInformation()
    assert(self.presenter != nil, "Modules were not assembed correctly")
    
    tableView.addCellIdentifiers(["GJContactInfoCell"])
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func showContactsInformation(with info: [GJContactInfo]){
    self.contacts = info
    print("Contacts info fetched is \(self.contacts)")
    
    // 1
    for contact in self.contacts {
      let firstName = contact.firstName?.trimmingCharacters(in: .whitespaces)
      let carKey = String(firstName!.prefix(1))
      if var carValues = contactsDictionary[carKey] {
        carValues.append(contact)
        contactsDictionary[carKey] = carValues
      } else {
        contactsDictionary[carKey] = [contact]
      }
    }
    
    // 2
    contactsSectionTitles = [String](contactsDictionary.keys)
    contactsSectionTitles = contactsSectionTitles.sorted(by: { $0 < $1 })
    print("Car sections  \(contactsSectionTitles)")
    print("carsDictionary Car sections  \(contactsDictionary)")
    tableView.reloadData()
  }

  func removeActivityView() {
    
  }
}

// MARK: - Extension for TableView DataSource
extension GJContactsViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let carKey = contactsSectionTitles[section]
    if let carValues = contactsDictionary[carKey] {
      return carValues.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "  \(contactsSectionTitles[section])"
  }
  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return contactsSectionTitles
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "GJContactInfoCell", for: indexPath) as! GJContactInfoCell
    let contactKey = contactsSectionTitles[indexPath.section]
    if let contactValues = contactsDictionary[contactKey] {
      cell.displayData(data: contactValues[indexPath.row])
    }
    
    return cell
  }
}

// MARK: - Extension for TableView Delegate
extension GJContactsViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
    return 50//UITableViewAutomaticDimension
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return contactsSectionTitles.count
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let contactKey = contactsSectionTitles[indexPath.section]
    if let contactValues = contactsDictionary[contactKey] {
      presenter?.sendDataToContactDetailView(info: contactValues[indexPath.row])
    }
    
  }
}


extension UIViewController: PayLoadFormat{
  func showErrorMessage(on field: GJTextField, message:String)  {
    GJInfoPopOverView.presentPopover(fromViewController: self , sourceView: field, message: message)
  }
}
