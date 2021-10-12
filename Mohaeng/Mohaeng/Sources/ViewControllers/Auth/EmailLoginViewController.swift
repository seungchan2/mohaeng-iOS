//
//  SignUpFirstViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var signUpUser = SignUpUser.shared
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    @IBOutlet weak var emailBottomView: UIView!
    @IBOutlet weak var passwordBottonView: UIView!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        makeButtonRound()
        initNavigationBar()
    }
    
    // MARK: - @IBAction Function
    @IBAction func touchLoginButton(_ sender: Any) {
        pushHomeViewController()
        
    }
    @IBAction func touchFindPasswordButton(_ sender: Any) {
        pushFindPasswordViewController()
    }
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func assignDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func makeButtonRound() {
        loginButton.makeRounded(radius: 20)
    }
    
    private func errorMessage() {
        errorLabel.isHidden = false
    }
    
    func finishEditingTextField() {
        emailLabel.textColor = .Grey2Text
        emailBottomView.backgroundColor = .Grey5
        passwordLabel.textColor = .Grey2Text
        passwordBottonView.backgroundColor = .Grey5
    }
    
    func pushHomeViewController() {
        let homeStoryboard = UIStoryboard(name: Const.Storyboard.Name.home, bundle: nil)
        guard let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.home) as? HomeViewController else {
            return
        }
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    func enableLoginButton() {
        loginButton.backgroundColor = .DeepYellow
        loginButton.isEnabled = true
    }
    
    private func pushFindPasswordViewController() {
        let findPasswordStoryboard = UIStoryboard(name: Const.Storyboard.Name.findPassword, bundle: nil)
        guard let findPasswordViewController = findPasswordStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.findPassword) as? FindPasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(findPasswordViewController, animated: true)
    }
    
}

// MARK: - Extensions

extension EmailLoginViewController: UITextFieldDelegate {

    // Editing 하면서 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.isEditing {
            emailLabel.textColor = .Black1Text
            emailBottomView.backgroundColor = .black
            loginButton.backgroundColor = .DeepYellow
        }
        
        if passwordTextField.isEditing {
            passwordLabel.textColor = .Black1Text
            passwordBottonView.backgroundColor = .black
            loginButton.backgroundColor = .DeepYellow
        }
    }
    
    // Editing 끝나고 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        finishEditingTextField()
        
        // emailTextField, passwordTextField 둘 중 하나라도 없으면 버튼 색 바꾸기
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = .LoginYellow
            loginButton.isEnabled = false
        }
    }
}

extension EmailLoginViewController {
    func postLogin() {
        guard let password = passwordTextField.text else {
            return
        }
        
        guard let email = emailTextField.text else {
            return
        }
        LoginAPI.shared.postSignIn(completion: { (response) in
            switch response {
            case .success(let jwt):
                if let data = jwt as? JwtData {
                    UserDefaults.standard.setValue(data.jwt, forKey: "jwtToken")
                    self.enableLoginButton()
                    self.pushHomeViewController()
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
                self.errorMessage()
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: email, password: password)
    }
}
