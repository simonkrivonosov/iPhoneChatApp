//
//  ProfileViewController.swift
//  Chat
//
//  Created by Семен Кривоносов on 22.09.2018.
//  Copyright © 2018 Семен Кривоносов. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate , DataManagerDelegate {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var aboutMeTextView: UITextView!
    @IBOutlet var aboutMeLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var operationButton: RoundedButton!
    @IBOutlet var gcdButton: RoundedButton!
    @IBOutlet weak var editButton: RoundedButton!
    @IBOutlet weak var profilePhoto: RoundedImage!
    @IBOutlet weak var changePhotoButton: RoundedView!
    @IBAction func tapDoneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapEditButton(_ sender: Any) {
        inEditingState = true
        saveButtonsEnabled = false
    }
    
    @IBAction func tapGCDButton(_ sender: Any) {
        if !(dataManager is GCDDataManager) {
            dataManager = GCDDataManager(usernameKey: usernameKey, aboutKey: aboutKey, avatarFile: avatarFile)
            dataManager.delegate = self
        }
        tryToSaveChangedValuesToDataManager()
    }
    
    @IBAction func tapOperationButton(_ sender: Any) {
        if !(dataManager is OperationDataManager) {
            dataManager = OperationDataManager(usernameKey: usernameKey, aboutKey: aboutKey, avatarFile: avatarFile)
            dataManager.delegate = self
        }
        tryToSaveChangedValuesToDataManager()
    }
    @IBAction func tapChangePhoto(_ sender: Any) {
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
    
    var dataManager: DataManager
    var logger: Logger = Logger()
    private var usernameKey: String
    private var aboutKey: String
    private var avatarFile: String
    private var shouldSaveNewName: Bool = false {
        didSet {
            if shouldSaveNewName || shouldSaveNewAbout || shouldSaveNewAvatar {
                saveButtonsEnabled = true
            } else {
                saveButtonsEnabled = false
            }
        }
    }
    private var shouldSaveNewAbout: Bool = false {
        didSet {
            if shouldSaveNewName || shouldSaveNewAbout || shouldSaveNewAvatar {
                saveButtonsEnabled = true
            } else {
                saveButtonsEnabled = false
            }
        }
    }
    private var shouldSaveNewAvatar: Bool = false {
        didSet {
            if shouldSaveNewName || shouldSaveNewAbout || shouldSaveNewAvatar {
                saveButtonsEnabled = true
            } else {
                saveButtonsEnabled = false
            }
        }
    }
    private var saveButtonsEnabled: Bool = false {
        didSet {
            if saveButtonsEnabled {
                gcdButton.isEnabled = true
                operationButton.isEnabled = true
                gcdButton.alpha = 1.0
                operationButton.alpha = 1.0
            } else {
                gcdButton.isEnabled = false
                operationButton.isEnabled = false
                gcdButton.alpha = 0.5
                operationButton.alpha = 0.5
            }
        }
    }
    private var inEditingState: Bool = false {
        didSet {
            if inEditingState {
                editButton.isHidden = true
                usernameLabel.isHidden = true
                aboutMeLabel.isHidden = true
                gcdButton.isHidden = false
                operationButton.isHidden = false
                changePhotoButton.isHidden = false
                usernameTextField.text = usernameLabel.text
                aboutMeTextView.text = aboutMeLabel.text
                if aboutMeTextView.text == nil || aboutMeTextView.text == "" {
                    aboutMeTextView.text = "О себе"
                    aboutMeTextView.textColor = UIColor.lightGray
                }
                usernameTextField.isHidden = false
                aboutMeTextView.isHidden = false
                usernameTextField.isEnabled = true
                aboutMeTextView.isEditable = true
                aboutMeTextView.isSelectable = true
            } else {
                editButton.isHidden = false
                usernameLabel.isHidden = false
                aboutMeLabel.isHidden = false
                gcdButton.isHidden = true
                operationButton.isHidden = true
                changePhotoButton.isHidden = true
                usernameTextField.isHidden = true
                aboutMeTextView.isHidden = true
            }
        }
    }
    
    func tryToSaveChangedValuesToDataManager() {
        activityIndicator.startAnimating()
        saveButtonsEnabled = false
        usernameTextField.isEnabled = false
        aboutMeTextView.isEditable = false
        aboutMeTextView.isSelectable = false
        changePhotoButton.isHidden = true
        var usernameToSave: String?
        var aboutToSave: String?
        var avatarToSave: UIImage?
        if shouldSaveNewName {
            usernameToSave = usernameTextField.text
        }
        if shouldSaveNewAbout {
            aboutToSave = aboutMeTextView.text
        }
        if shouldSaveNewAvatar {
            avatarToSave = profilePhoto.image
        }
        dataManager.saveData(username: usernameToSave, about: aboutToSave, avatar: avatarToSave)
    }
    func savingDataFinished() {
        activityIndicator.stopAnimating()
        let actionSheet = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: UIAlertController.Style.alert)
        actionSheet.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { (alert:UIAlertAction!) -> Void in
            self.saveButtonsEnabled = false
            self.inEditingState = false
            self.editButton.isEnabled = false
            self.editButton.alpha = 0.5
            self.loadDataFromDataManager()
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func savingDataFailed() {
        activityIndicator.stopAnimating()
        let actionSheet = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: UIAlertController.Style.alert)
        actionSheet.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.tryToSaveChangedValuesToDataManager()
        }))
        actionSheet.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { (alert:UIAlertAction!) -> Void in
            self.saveButtonsEnabled = false
            self.inEditingState = false
            self.editButton.isEnabled = false
            self.editButton.alpha = 0.5
            self.loadDataFromDataManager()
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func loadDataFromDataManager() {
        activityIndicator.startAnimating()
        dataManager.loadData()
    }
    func loadingDataFinished() {
        activityIndicator.stopAnimating()
        usernameLabel.text = dataManager.username
        aboutMeLabel.text = dataManager.about
        if dataManager.avatar != nil {
            profilePhoto.image = dataManager.avatar
        }
        shouldSaveNewName = false
        shouldSaveNewAbout = false
        shouldSaveNewAvatar = false
        editButton.isEnabled = true
        editButton.alpha = 1.0
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == usernameTextField {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                if updatedText != dataManager.username {
                    shouldSaveNewName = true
                } else {
                    shouldSaveNewName = false
                }
            }
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == aboutMeTextView {
            if textView.textColor == UIColor.lightGray {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView == aboutMeTextView {
            if textView.textColor == UIColor.lightGray {
                textView.text = ""
                textView.textColor = UIColor.black
            }
            if let updatedText = textView.text, updatedText != dataManager.about {
                shouldSaveNewAbout = true
            } else {
                shouldSaveNewAbout = false
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profilePhoto.image = image
            if areTwoEqualImages(dataManager.avatar, profilePhoto.image) {
                shouldSaveNewAvatar = false
            } else {
                shouldSaveNewAvatar = true
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    func areTwoEqualImages(_ image1: UIImage?, _ image2: UIImage?) -> Bool {
        if let img1 = image1, let img2 = image2 {
            guard let data1 = img1.pngData() else { return false }
            guard let data2 = img2.pngData() else { return false }
            return data1.elementsEqual(data2)
        } else {
            return false
        }
    }
      required init?(coder aDecoder: NSCoder) {
        usernameKey = "username"
        aboutKey = "about"
        avatarFile = "avatar.png"
        dataManager = GCDDataManager(usernameKey: usernameKey, aboutKey: aboutKey, avatarFile: avatarFile)
        super.init(coder: aDecoder)
        dataManager.delegate = self
        
        
       // print(self.editButton.frame)
      //We will have error here , because editButton is haven't been initialized yet , so it is nil
      }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= (keyboardFrame.height - (self.view.frame.size.height - self.editButton.frame.origin.y - self.editButton.frame.size.height))
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.logCurMethod(methodName: #function)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        saveButtonsEnabled = false
        inEditingState = false
        editButton.isEnabled = false
        editButton.alpha = 0.5
        loadDataFromDataManager()
        
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
        
//        let cornerRadius = self.changePhotoButton.frame.size.height / 2
//        self.changePhotoButton.layer.cornerRadius = cornerRadius
//        self.changePhotoButton.layer.masksToBounds = true
//        //self.changePhotoButton.imageView?.contentMode = .scaleAspectFit
//        self.changePhotoButton.imageEdgeInsets = UIEdgeInsets(
//            top: cornerRadius / 2.5,
//            left: cornerRadius / 2.5,
//            bottom: cornerRadius / 2.5,
//            right: cornerRadius / 2.5)
//
//        self.profilePhoto.layer.masksToBounds = true
//        self.profilePhoto.layer.cornerRadius = cornerRadius
//
//        self.editButton.layer.cornerRadius = cornerRadius / 4
//        self.editButton.layer.borderWidth = 1.5
//        self.editButton.layer.borderColor = UIColor.black.cgColor
//        self.editButton.titleEdgeInsets = UIEdgeInsets(
//            top: cornerRadius / 2,
//            left: cornerRadius / 2,
//            bottom: cornerRadius / 2,
//            right: cornerRadius / 2)
        
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

