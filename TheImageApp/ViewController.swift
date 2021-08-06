//
//  ViewController.swift
//  TheImageApp
//
//  Created by Shelley Gertrudis on 8/6/21.
//  Copyright © 2021 Shelley Gertrudis. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController,animated: true,completion: nil)
    }
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://intra.42.fr"){
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image source", message: "Sosi hui", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler:
            {
                action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let photolibraryAction = UIAlertAction(title: "Photo library", style: .default, handler:
            {
                action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photolibraryAction)
        }
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectImage =
            info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = selectImage
//            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        if !MFMailComposeViewController.canSendMail(){
            print("Go fuck yourself")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["msnazarow@gmail.com"])
        mailComposer.setSubject("I am the king of the World")
        mailComposer.setMessageBody("Hello boy", isHTML: false)
        present(mailComposer,animated: true, completion: nil)
    }
    func  mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

