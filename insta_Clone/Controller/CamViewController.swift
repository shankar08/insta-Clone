//
//  CamViewController.swift
//  insta_Clone
//
//  Created by dto_admin on 3/12/18.
//  Copyright © 2018 Shankar Prajapati. All rights reserved.
//

import UIKit

class CamViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var textInputField: UITextView!
    
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        textInputField.delegate = self
        picker.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        
        textInputField.text = "Write Something..."
        
        textInputField.textColor = UIColor.lightGray
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textInputField.textColor == UIColor.lightGray {
            textInputField.text = ""
            textInputField.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textInputField.text == "" {
            
            textInputField.text = "Write Something..."
            textInputField.textColor = UIColor.lightGray
        }
        self.resignFirstResponder()
    }
    
    @IBAction func onShareBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func onCancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   //when the takephoto button is pressed
    
    @IBAction func onPhotoBtnPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        }else {
            let alertVC = UIAlertController(title: "No hardware ", message: "Your device doesnot have a physical camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
        }
        
        
    }
    @IBAction func onGalleryBtnPressed(_ sender: Any) {
       // let picker = UIImagePickerController()
        
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var choosenImage = UIImage()
        
        choosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        pickedImage.image = choosenImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardDismiss()
        
        return true
    }
    func keyboardDismiss() {
        textInputField.resignFirstResponder()
    }
}
