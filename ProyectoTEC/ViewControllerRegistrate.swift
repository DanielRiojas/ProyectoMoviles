//
//  ViewControllerRegistrate.swift
//  ProyectoTEC
//
//  Created by user197925 on 10/7/21.
//

import UIKit

class ViewControllerRegistrate: UIViewController {
    
    
    
    @IBOutlet weak var registrate: UIButton! // Button
    
    @IBOutlet weak var tf_correo: UITextField! // Textfield
    @IBOutlet weak var tf_contrasena: UITextField!
    @IBOutlet weak var tf_repiteContrasena: UITextField!
    @IBOutlet weak var tf_nombre: UITextField!
    @IBOutlet weak var tf_apellidoPaterno: UITextField!
    @IBOutlet weak var tf_apellidoMaterno: UITextField!
    @IBOutlet weak var tf_fechaNacimiento: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Button Configuration
        registrate.layer.cornerRadius = 25
        //registrate.addTarget(self, action: #selector(signInGoogle(_:)), for: .touchUpInside)
        
        // TextField Configuration
        tf_contrasena.isSecureTextEntry = true
        tf_repiteContrasena.isSecureTextEntry = true
        
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
        if tf_correo.text! == "" || tf_contrasena.text! == "" || tf_repiteContrasena.text! == "" || tf_nombre.text! == "" || tf_apellidoPaterno.text! == "" || tf_apellidoMaterno.text! == "" || tf_fechaNacimiento.text! == "" {
            let alerta = UIAlertController(title: "Error", message: "Coloca datos en todos los campos", preferredStyle: .alert)
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
        if (sender as! UIButton) == registrate {
            let vistaIni = segue.destination as! ViewController
            vistaIni.correoEletronico = tf_correo.text!
            vistaIni.contrasena = tf_contrasena.text!
        }
    }
    

}
