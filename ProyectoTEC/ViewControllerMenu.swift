//
//  ViewControllerMenu.swift
//  ProyectoTEC
//
//  Created by Daniel Riojas on 14/10/21.
//

import FirebaseAuth
import FirebaseFirestore
import Firebase
import UIKit

class ViewControllerMenu: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var listaSintomas = [
        celdaSintomas(nombre: "Fiebre"),
        celdaSintomas(nombre: "Tos"),
        celdaSintomas(nombre: "Cansancio"),
        celdaSintomas(nombre: "Perdida olfato"),
        celdaSintomas(nombre: "Perdida del sabor")
    ]

    @IBOutlet weak var tableViewSintomas: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Métodos de Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaSintomas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSintomas.dequeueReusableCell(withIdentifier: "celda") as! CustomTableViewCell
        
        cell.lbNombre.text = listaSintomas[indexPath.row].nombre
        cell.lbSiNo = listaSintomas[indexPath.row].respuesta
        
        return cell
    }
    
    //MARK: - logout databse
    
    @IBAction func logOutPressed(_ sender: Any) {
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut()
            print("Logout successfull")
            self.dismiss(animated: true, completion: nil)
        }
        catch {
            print ("Error, there was a problem singing out")
        }
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
