//
//  ViewController.swift
//  Chat
//
//  Created by Семен Кривоносов on 22.09.2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    
    @IBAction func tapChangePhoto(_ sender: UIButton) {
        let changePhotoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        changePhotoAlert.addAction(UIAlertAction(title: "Установить из галереи", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePickerController.sourceType = .photoLibrary
                self.imagePickerController.allowsEditing = true
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
        }))
        changePhotoAlert.addAction(UIAlertAction(title: "Сделать фото", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerController.sourceType = .camera
                self.imagePickerController.allowsEditing = false
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
        }))
        changePhotoAlert.addAction(
            UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(changePhotoAlert, animated: true)
    }
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
          self.profilePhoto.image = image
        }
        dismiss(animated: true)
      }
    
    //  required init?(coder aDecoder: NSCoder) {
    //    super.init(coder: aDecoder)
    //    print(self.editButton.frame)
    //  We will have error here , because editButton is haven't been initialized yet , so it is nil
    //  }
    
    var logger: Logger = Logger()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        logger.logCurMethod(methodName: #function)
        //print(self.editButton.frame) No mistake!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//
//        logger.logCurMethod(methodName: #function)
//        let cornerRadius = self.changePhotoButton.frame.size.height / 1.75
//        self.changePhotoButton.layer.cornerRadius = cornerRadius
//        self.changePhotoButton.layer.masksToBounds = true
//        self.changePhotoButton.imageView?.contentMode = .scaleAspectFit
//        self.changePhotoButton.imageEdgeInsets = UIEdgeInsets(
//            top: cornerRadius/2.5,
//            left: cornerRadius/2.5,
//            bottom: cornerRadius/2.5,
//            right: cornerRadius/2.5)
//
//        self.profilePhoto.layer.cornerRadius = cornerRadius
//        self.profilePhoto.layer.masksToBounds = true
//
//        self.editButton.layer.cornerRadius = cornerRadius / 4
//        self.editButton.layer.borderWidth = 1.5
//        self.editButton.layer.borderColor = UIColor.black.cgColor
//        self.editButton.titleEdgeInsets = UIEdgeInsets(
//            top: cornerRadius / 2,
//            left: cornerRadius / 2,
//            bottom: cornerRadius / 2,
//            right: cornerRadius / 2)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let cornerRadius = self.changePhotoButton.frame.size.height / 2
        self.changePhotoButton.layer.cornerRadius = cornerRadius
        self.changePhotoButton.layer.masksToBounds = true
        self.changePhotoButton.imageView?.contentMode = .scaleAspectFit
        self.changePhotoButton.imageEdgeInsets = UIEdgeInsets(
            top: cornerRadius / 2.5,
            left: cornerRadius / 2.5,
            bottom: cornerRadius / 2.5,
            right: cornerRadius / 2.5)
        
        self.profilePhoto.layer.cornerRadius = cornerRadius
        self.profilePhoto.layer.masksToBounds = true
        
        self.editButton.layer.cornerRadius = cornerRadius / 4
        self.editButton.layer.borderWidth = 1.5
        self.editButton.layer.borderColor = UIColor.black.cgColor
        self.editButton.titleEdgeInsets = UIEdgeInsets(
            top: cornerRadius / 2,
            left: cornerRadius / 2,
            bottom: cornerRadius / 2,
            right: cornerRadius / 2)
        
        //print(self.editButton.frame) values of the frames are different because in veiwDidLoad methood constraints haven't been set yet.

        logger.logCurMethod(methodName: #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logger.logCurMethod(methodName: #function)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        logger.logCurMethod(methodName: #function)
    }
}

