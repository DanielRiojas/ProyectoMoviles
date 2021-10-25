//
//  ViewController.swift
//  ProyectoTEC
//
//  Created by user197925 on 10/4/21.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class ViewController: UIViewController {
    
    @IBOutlet weak var googleSignIn: UIButton! // Button
    @IBOutlet weak var appleSignIn: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var olvidasteContrasena: UIButton!
    @IBOutlet weak var registrate: UIButton!
    
    @IBOutlet weak var tf_correoElectronico: BindingTextField! // Textfield
    @IBOutlet weak var tf_contrasena: UITextField!
    
    var correoEletronico = ""
    var contrasena = ""
    var emailIsValid = false
    
    // MARK:- Button action
    @objc func signInGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
        // Update screen after user successfully signed in
        updateScreen()
    }

    @objc func signOutGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signOut()
        // Update screen after user successfully signed out
        updateScreen()
    }
    
    @objc func signInApple(_ sender: UIButton) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    // MARK:- Unwind
    
    @IBAction func unwindRegistrate (segue: UIStoryboardSegue) {
        tf_correoElectronico.text = correoEletronico
        tf_contrasena.text = contrasena
    }
    
    @IBAction func unwindCambiarContrasena (segue: UIStoryboardSegue) {
        tf_correoElectronico.text = correoEletronico
        tf_contrasena.text = contrasena
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup email validation
        emailValidation()
        
        // Button Configuration
        googleSignIn.layer.cornerRadius = 25
        googleSignIn.addTarget(self, action: #selector(signInGoogle(_:)), for: .touchUpInside)
        
        appleSignIn.layer.cornerRadius = 25
        appleSignIn.addTarget(self, action: #selector(signInApple(_:)), for: .touchUpInside)
        
        login.layer.cornerRadius = 25
        
        // TextField Configuration
        tf_contrasena.isSecureTextEntry = true
        
        
        // Let GIDSignIn know that this view controller is presenter of the sign-in sheet
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Register notification to update screen after user successfully signed in
        NotificationCenter.default.addObserver(self, selector: #selector(userDidSignInGoogle(_:)), name: .signInGoogleCompleted, object: nil)
                
        // Update screen base on sign-in/sign-out status (when screen is shown)
        updateScreen()
        
        // Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
        }
            
        private func updateScreen() {
            if let user = GIDSignIn.sharedInstance()?.currentUser { // User signed in
                print("User signed in")
            }
            else { // User signed out
                print("User signed out")
            }
        }
    
    // MARK: - Eliminate Keyboard
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    // MARK: - Email validation
    func emailValidation() {
        tf_correoElectronico.bind { [weak self] (text) in if let isValid = self?.isValidEmail(text) {
                if (isValid == true) {
                    self?.emailIsValid = true
                }
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    
    // MARK:- Notification
        @objc private func userDidSignInGoogle(_ notification: Notification) {
            // Update screen after user successfully signed in
            updateScreen()
        }
    }



extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Failed!")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let fullName = credentials.fullName?.givenName
            let email = credentials.email!
            let userID = credentials.user
            print("Full name: \(fullName) - UserID: \(userID) - Email: \(email)")
            break
        case let credentials as ASPasswordCredential:
            let password = credentials.password
            print("Password: \(password)")
        
        default:
            break
        }
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

class BindingTextField: UITextField {
    var textEdited: ((String) -> Void)? = nil

    func bind(completion: @escaping (String) -> Void) {
        textEdited = completion
        addTarget(self, action: #selector(textFieldEditingChanged (_:)), for: .editingChanged)
    }

    @objc func textFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textEdited?(text)
    }
}



