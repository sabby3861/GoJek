//
//  GJContactDetailViewController.swift
//  GoJek
//
//  Created by sanjay on 12/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit
import MessageUI

struct GJContactDetailInfo {
  var key: String
  var value: String
  var type: GJFieldType!
  var jsonKey: String
}

class GJContactDetailViewController: UIViewController, GJContactDeailViewProtocol {
  var presenter: GJContactDeailPresenterProtocol?
  var contact: GJContactInfo?
  var contactDetail: GJContactDetail?
  var items:[GJContactDetailInfo] = [GJContactDetailInfo]()
  var canEdit = false
  var detailView: GJContactDetailVIew?
  var jsonData = [String:String]()
  var activity: GJActivityView!
  @IBOutlet weak var tableView: GJTableView!
  
  func showContactsInformation(with info: GJContactDetail) {
    
    var contactInfo = GJContactDetailInfo(key: "First Name", value: info.firstName, type: .userName, jsonKey: "first_name")
    items.append(contactInfo)
    contactInfo = GJContactDetailInfo(key: "Last Name", value: info.lastName, type: .userName, jsonKey: "last_name")
    items.append(contactInfo)
    contactInfo = GJContactDetailInfo(key: "mobile", value: info.phone != nil ? info.phone! : "", type: .telephone, jsonKey: "phone_number")
    items.append(contactInfo)
    contactInfo = GJContactDetailInfo(key: "email", value: info.email != nil ? info.email! : "", type: .email, jsonKey: "email")
    items.append(contactInfo)
    self.contactDetail = info
    let url = "\(baseUrl)\(contactDetail?.profilePic ?? "")"
    detailView?.userImageView.loadImageUsingCacheWithURLString(url, placeHolder: #imageLiteral(resourceName: "NoImage"))
    DispatchQueue.main.async {
      self.activity.removeActivity()
      self.tableView.reloadData()
    }
  }
  
  func removeActivityView() {
    DispatchQueue.main.async {
      self.activity.removeActivity()
    }
  }
  
  
  @IBAction func editButtonClicked(_ sender: Any) {
    self.view.endEditing(true)
    if self.navigationItem.rightBarButtonItem?.title == GJButtonTitle.done.description {
      updateDataOnSever()
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
  
  func updateDataOnSever() {
    if shouldUpdateData() && self.jsonData.count > 0{
      DispatchQueue.main.async {
        self.activity.showActivityIndicatory(uiView: self.view)
      }
      formatPostPayload(json: jsonData, type: .RequestMethodPUT)
      self.presenter?.sendDataToContactDetailView(contactId: (contactDetail?.id)!)
    }
  }
  func shouldUpdateData() -> Bool {
    for (_ , value) in self.jsonData {
      if value.count > 0 {
        return true
      }
    }
    return false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activity = GJActivityView()
    activity.showActivityIndicatory(uiView: self.view)
    self.presenter?.fetchContactsDetail(id: (contact?.contactId)!)
    tableView.addCellIdentifiers(["GJContactDetailCell"])
    // Do any additional setup after loading the view.
    tableView.contentInset = UIEdgeInsetsMake(310, 0, 0, 0)
    detailView = GJContactDetailVIew.initWithNIb()
    detailView?.delegate = self
    view.addSubview(detailView!)
    addNotificationAndSetup()
  }
  
  func addNotificationAndSetup()  {
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(notification:NSNotification)  {
    adjustingHeight(show: true, notification: notification)
  }
  
  func adjustingHeight(show:Bool, notification:NSNotification) {
    
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      let changeInHeight = (keyboardSize.height - 64) * (show ? 1 : -1)
      UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
        let frame = self.view.frame
        self.view.frame = CGRect.init(x: frame.origin.x, y: -changeInHeight, width: frame.width, height: frame.height)
      }, completion: { (finished: Bool) in
        
      })
    }
  }
  @objc func keyboardWillHide(notification:NSNotification)  {
    
    UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
      let frame = self.view.frame
      self.view.frame = CGRect.init(x: frame.origin.x, y: 0, width: frame.width, height: frame.height)
    }, completion: { (finished: Bool) in
      
    })
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
    cell.infoTextField.updateValue =  {[unowned self](textfield: GJTextField, string:String) in
        self.jsonData[contactInfo.jsonKey] = string
    }
    cell.infoTextField.errorMessage = {[unowned self](textfield: GJTextField, string:String) in
      self.showErrorMessage(on: textfield, message: string)
    }
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
 
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let y = 310 - (scrollView.contentOffset.y + 310)
    let height = min(max(y, 60), 310)
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
    detailView?.userImageView.contentMode = .scaleAspectFit
    detailView?.userImageView.image = chosenImage
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

extension GJContactDetailViewController: MFMailComposeViewControllerDelegate{
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

extension GJContactDetailViewController: GJContactDetailDelegate, GJAlertDelegate{
  func favouriteButtonClicked(){
    
  }
  func emailButtonClicked(){
    if let email = contactDetail?.email {
      presenter?.router?.sendEmail(email: email)
    }else{
      showMessage(message: "Email is not available")
    }
    
  }
  func phoneButtonClicked(){
    if let phoneNumber = contactDetail?.phone {
      presenter?.router?.startTheCall(to: phoneNumber)
    }else{
      showMessage(message: "Phone number is not available")
    }
  }
  func messageButtonClicked(){
    if let phoneNumber = contactDetail?.phone {
      presenter?.router?.sendEmail(email: phoneNumber)
    }else{
      showMessage(message: "Phone number is not available")
    }
    
  }
  func showMessage(message: String){
    DispatchQueue.main.async {
      GJAlertViewController.showAlert(withTitle: "Error", message:  message)
    }
  }

  func cameraButtonClicked(){
    GJAlertViewController.showAlert(withTitle: "GoJek", message: "Please choose", buttons: ["Camera", "Photo Library"], delegate: self)
  }
  
  func alert(buttonClickedIndex:Int, buttonTitle: String, tag: Int){
    if buttonTitle == "Camera" {
      presenter?.router?.showCameraOrPhotoLibrary(type: .camera)
    }else if buttonTitle == "Photo Library"{
      presenter?.router?.showCameraOrPhotoLibrary(type: .library)
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

