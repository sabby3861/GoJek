//
//  GJContactDetailViewController.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit
import MessageUI

enum GJFieldType{
case number
case email
case text
case password
case telephone
case userName
case allChars
case none
}
struct GJContactDetailInfo {
  var key:String
  var value:String
  var type:GJFieldType!
}

class GJContactDetailViewController: UIViewController, GJContactDeailViewProtocol {
  var presenter: GJContactDeailPresenterProtocol?
  var contact: GJContactInfo?
  var contactDetail: GJContactDetail?
  var items:[GJContactDetailInfo] = [GJContactDetailInfo]()
  var canEdit = false
  var detailView: GJContactDetailVIew?
  
  @IBOutlet weak var tableView: GJTableView!
  func showContactsInformation(with info: GJContactDetail) {
    
    var contactInfo = GJContactDetailInfo(key: "First Name", value: info.firstName, type: .text)
    items.append(contactInfo)
    contactInfo = GJContactDetailInfo(key: "Last Name", value: info.lastName, type: .text)
    items.append(contactInfo)
    contactInfo = GJContactDetailInfo(key: "mobile", value: info.phone != nil ? info.phone! : "", type: .text)
    items.append(contactInfo)
    contactInfo = GJContactDetailInfo(key: "email", value: info.email != nil ? info.email! : "", type: .text)
    items.append(contactInfo)
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func removeActivityView() {
    
  }
  
  
  @IBAction func editButtonClicked(_ sender: Any) {
    if self.navigationItem.rightBarButtonItem?.title == GJButtonTitle.done.description {
      self.navigationItem.rightBarButtonItem?.title = GJButtonTitle.edit.description
      canEdit = false
    }else{
      self.navigationItem.rightBarButtonItem?.title = GJButtonTitle.done.description
      canEdit = true
    }
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.fetchContactsDetail(id: (contact?.contactId)!)
    tableView.addCellIdentifiers(["GJContactDetailCell"])
    // Do any additional setup after loading the view.
    tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0)
    detailView = GJContactDetailVIew.initWithNIb()
    view.addSubview(detailView!)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}


// MARK: - Extension for TableView DataSource
extension GJContactDetailViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "GJContactDetailCell", for: indexPath) as! GJContactDetailCell
    let contactInfo = items[indexPath.row]
    cell.displayData(data: contactInfo, enabled: canEdit)
    return cell
  }
}

// MARK: - Extension for TableView Delegate
extension GJContactDetailViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
    return UITableViewAutomaticDimension
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let y = 300 - (scrollView.contentOffset.y + 300)
    let height = min(max(y, 60), 400)
    if let detailView = detailView {
      detailView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
  }
}


// MARK: - Extension for handleing Image Picker Delegates
extension GJContactDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  //MARK: - Delegates
  private func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : AnyObject])
  {
    var  chosenImage = UIImage()
    chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    //myImageView.contentMode = .scaleAspectFit
    //myImageView.image = chosenImage 
    dismiss(animated:true, completion: nil)
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
}


// MARK: - Extesnion for handeling Message Delegates
extension GJContactDetailViewController: MFMessageComposeViewControllerDelegate{
  func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    switch (result.rawValue) {
    case MessageComposeResult.cancelled.rawValue:
      print("Message was cancelled")
      self.dismiss(animated: true, completion: nil)
    case MessageComposeResult.failed.rawValue:
      print("Message failed")
      self.dismiss(animated: true, completion: nil)
    case MessageComposeResult.sent.rawValue:
      print("Message was sent")
      self.dismiss(animated: true, completion: nil)
    default:
      break;
    }
  }

}

enum GJButtonTitle: String, CustomStringConvertible{
  case done = "Done"
  case edit = "Edit"
  var description: String {
    return self.rawValue
  }
}

enum GJCameraType: String, CustomStringConvertible{
  case camera = "Camera"
  case library = "PhotoLibrary"
  var description: String {
    return self.rawValue
  }
}

