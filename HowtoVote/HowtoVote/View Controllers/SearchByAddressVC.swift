//
//  SearchByAddressVC.swift
//  HowtoVote
//
//  Created by Amir Fleminger on 8/14/18.
//  Copyright © 2018 Code for Orlando. All rights reserved.
//

import UIKit

class SearchByAddressVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    var inputFields:[UITextField]?
    let scrollView = UIScrollView()

    let stackView:UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 15
        return sv
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Find Voting Location", for: .normal)
        btn.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return btn
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerKeyboardNotifications()
        title = "Enter Your Address"
        submitButton.addTarget(self, action:#selector(self.submitTapped), for: .touchUpInside)
        view.addSubview(scrollView)
        createInputFields()
        stackView.addArrangedSubview(submitButton)
        scrollView.addSubview(stackView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureScrollViewConstraints()
        configureStackViewConstraints()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Auto Layout
    func configureScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureStackViewConstraints() {
        let padding:CGFloat = 15
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.75).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    // MARK: - Input fields
    func createInputFields(){
        inputFields = [
            inputField(placeholder: "Address Line 1", contentType: .streetAddressLine1),
            inputField(placeholder: "Address Line 2", contentType: .streetAddressLine2),
            inputField(placeholder: "City", contentType: UITextContentType.addressCity),
            inputField(placeholder: "State", contentType: UITextContentType.addressState),
            inputField(placeholder: "Zip", contentType: .postalCode)
        ]
        for inField in inputFields! {
            stackView.addArrangedSubview(inField)
            inField.delegate = self
        }
    }
    
    func inputField(placeholder:String, contentType:UITextContentType?) -> UITextField{
        let inputField = UITextField(frame: .zero)
        inputField.placeholder = placeholder
        inputField.textContentType = contentType
        inputField.borderStyle = .roundedRect
        return inputField
    }
    
    // MARK: - Button actions
    @objc func submitTapped() {
        view.endEditing(true)
        let searchResultsVC = SearchResultsVC()
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    // MARK: - Keyboard listeners
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification){
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}
