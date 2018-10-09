//
//  ProfileViewController.swift
//  Chat
//
//  Created by Семен Кривоносов on 22.09.2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBAction func tapDoneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapChangePhoto(_ sender: UIButton) {
        let changePhotoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        changePhotoAlert.addAction(UIAlertAction(title: "Установить из галереи", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else {
                let galleryProblemAlert = UIAlertController(title: nil, message: "Не удалось открыть галлерею", preferredStyle: .alert)
                galleryProblemAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(galleryProblemAlert, animated: true)
            }
        }))
        changePhotoAlert.addAction(UIAlertAction(title: "Сделать фото", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
            else {
                let cameraProblemAlert = UIAlertController(title: nil, message: "Не удалось открыть камеру", preferredStyle: .alert)
                cameraProblemAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(cameraProblemAlert, animated: true)
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
        logger.logCurMethod(methodName: #function)
        //print(self.editButton.frame) No mistake!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //print(self.editButton.frame) values of the frames are different because in veiwDidLoad methood constraints haven't been set yet.

        logger.logCurMethod(methodName: #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logger.logCurMethod(methodName: #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let cornerRadius = self.changePhotoButton.frame.size.height / 2
        self.changePhotoButton.layer.cornerRadius = cornerRadius
        self.changePhotoButton.layer.masksToBounds = true
        //self.changePhotoButton.imageView?.contentMode = .scaleAspectFit
        self.changePhotoButton.imageEdgeInsets = UIEdgeInsets(
            top: cornerRadius / 2.5,
            left: cornerRadius / 2.5,
            bottom: cornerRadius / 2.5,
            right: cornerRadius / 2.5)
        
        self.profilePhoto.layer.masksToBounds = true
        self.profilePhoto.layer.cornerRadius = cornerRadius
        
        self.editButton.layer.cornerRadius = cornerRadius / 4
        self.editButton.layer.borderWidth = 1.5
        self.editButton.layer.borderColor = UIColor.black.cgColor
        self.editButton.titleEdgeInsets = UIEdgeInsets(
            top: cornerRadius / 2,
            left: cornerRadius / 2,
            bottom: cornerRadius / 2,
            right: cornerRadius / 2)
        
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

