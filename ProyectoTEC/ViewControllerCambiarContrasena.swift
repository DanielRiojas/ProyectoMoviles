//
//  ViewControllerCambiarContrasena.swift
//
//
//  Created by user197925 on 10/11/21.
//

import FirebaseAuth
import FirebaseFirestore
import Firebase
import UIKit

class ViewControllerCambiarContrasena: UIViewController {

    @IBOutlet weak var tf_nuevaContrasena: UITextField! // TextFields
    @IBOutlet weak var tf_confirmaContrasena: UITextField!
    
    @IBOutlet weak var cambiarContrasena: UIButton! // Buttons
    
    let db = Firestore.firestore()
    var correo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Button Configuration
        cambiarContrasena.layer.cornerRadius = 25
        //cambiarContrasena.addTarget(self, action: #selector(signInGoogle(_:)), for: .touchUpInside)
        
        // TextField Configuration
        tf_nuevaContrasena.isSecureTextEntry = true
        tf_confirmaContrasena.isSecureTextEntry = true
        
        // Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Eliminate Keyboard
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    // MARK: - Prepare for segue
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tf_nuevaContrasena.text! == "" || tf_confirmaContrasena.text! == "" {
            let alerta = UIAlertController(title: "Error", message: "Coloca datos en todos los campos", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
            return false
        }
        else if (tf_nuevaContrasena.text! != tf_confirmaContrasena.text!) {
            let alerta = UIAlertController(title: "Error", message: "Las contraseñas no coinciden", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
            return false
        }
        else {
            return true
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as! UIButton) == cambiarContrasena {
            let vistaIni = segue.destination as! ViewController
            vistaIni.correoEletronico = correo
            vistaIni.contrasena = tf_confirmaContrasena.text!
        }
    }
    
    //MARK: - Modificar datos (password)
    
    /*func updateData(unLogIn: LogIn){
        if let docID = unLogIn.ident{
            do {
                try db.collection ("login").document(ID).setData(unLogIn)
            }
            catch {
                print ("Error while trying to update \(error.localizedDescription)")
            }
        }
            else {
            print ("Error while trying to update, no id is avaliable")
        }
    }*/

}
