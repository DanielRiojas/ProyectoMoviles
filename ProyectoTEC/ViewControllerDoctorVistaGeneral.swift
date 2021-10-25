//
//  ViewControllerDoctorVistaGeneral.swift
//  ProyectoTEC
//
//  Created by user197925 on 10/25/21.
//

import UIKit

class ViewControllerDoctorVistaGeneral: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var btn_configuraPerfil: UIButton!
    @IBOutlet weak var btn_logout: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    let data = ["Apples", "Oranges", "Pears", "Bananas", "Plums"]
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup Table View
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = data
        
        // Image View Configuration
        imgView.layer.cornerRadius = imgView.frame.height/2
        
        // Button Configuration
        btn_logout.layer.cornerRadius = 25
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)

        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
    }
    
    // MARK: - Search Bar Configuration
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = data
        }
        else {
            for paciente in data {
                if paciente.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(paciente)
                }
            }
        }
        self.tableView.reloadData()
    }

}
