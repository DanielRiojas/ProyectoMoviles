//
//  ViewControllerCofigPerfil.swift
//  ProyectoTEC
//
//  Created by Daniel Riojas on 14/10/21.
//

import UIKit

class ViewControllerCofigPerfil: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    // Tap Gesture
    let tap = UITapGestureRecognizer(target: self, action: #selector(quitaTeclado))
    view.addGestureRecognizer(tap)
}

// MARK: - Eliminate Keyboard
@IBAction func quitaTeclado() {
    view.endEditing(true)
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
