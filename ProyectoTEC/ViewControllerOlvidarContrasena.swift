//
//  ViewControllerOlvidarContrasena.swift
//  ProyectoTEC
//
//  Created by user197925 on 10/11/21.
//
import FirebaseAuth
import Firebase
import FirebaseFirestore
import UIKit

class ViewControllerOlvidarContrasena: UIViewController {
    
    @IBOutlet weak var tf_nombre: UITextField! // TextFields
    @IBOutlet weak var tf_apellidoPaterno: UITextField!
    @IBOutlet weak var tf_apellidoMaterno: UITextField!
    @IBOutlet weak var tf_fechaNacimiento: UITextField!
    @IBOutlet weak var tf_correo: UITextField!
    
    @IBOutlet weak var verificaDatos: UIButton! // Buttons
    
    let db = Firestore.firestore()
    var listaLogin = [" "]
    var emailIsValid = false
    var datePicker: UIDatePicker?
    var pickerToolbar: UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Textfield with date
        dateTextfield()
        
        // Button Configuration
        verificaDatos.layer.cornerRadius = 25
        
        
        // Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Eliminate Keyboard
    @IBAction func quitaTeclado() {
        view.endEditing(true)
    }
    
    // MARK: - Textfield with date
    func dateTextfield() {
        pickerToolbar = UIToolbar()
        pickerToolbar?.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked(_:)))
        pickerToolbar?.setItems([doneButton], animated: true)
        tf_fechaNacimiento.inputAccessoryView = pickerToolbar
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 100)
        tf_fechaNacimiento.inputView = datePicker
    }
        
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        tf_fechaNacimiento.text = dateFormatter.string(from: datePicker!.date)
        view.endEditing(true)
        }
        
    // MARK: - Prepare for segue
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tf_nombre.text! == "" || tf_apellidoPaterno.text! == "" || tf_apellidoMaterno.text! == "" || tf_fechaNacimiento.text! == "" || tf_correo.text! == "" {
            let alerta = UIAlertController(title: "Error", message: "Coloca datos en todos los campos", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
            return false
        }
        else if (emailIsValid == false) {
            let alerta = UIAlertController(title: "Error", message: "Correo electrónico no es valido", preferredStyle: .alert)
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
         if (sender as! UIButton) == verificaDatos {
             let vistaCambiarContrasena = segue.destination as! ViewControllerCambiarContrasena
             vistaCambiarContrasena.correo = tf_correo.text!
             
         }
     }
    
    //MARK:- obtener datos
    func getData(){
        db.collection("Login").order(by: "nombre").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                guard let _ = querySnapshot else { return }
                
                self.listaLogin.removeAll()
                
                for document in querySnapshot!.documents{
                    let data = document.data()
                    let nombre = data["nombre"] as! String
                    let apellidoPat = data["apellidoPaterno"] as! String
                    let apellidoMat = data["apellidoMaterno"] as! String
                    let fechaNac = data["fechaNacimiento"] as! String
                    let email = data["email"] as! String
                    let password = data["password"] as! String
                    let ident = document.documentID
                    
                    let nuevoLogin = LogIn()
                    
                    //self.listaLogin.append(nuevoLogin)
                }
                   // self.tableView.reloadData()
            }
        }
    }

}
