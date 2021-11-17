//
//  firestore.swift
//  ProyectoTEC
//
//  Created by Ana Lucía Treviño González on 04/11/21.
//

import UIKit

let ID = "rvodaOncAtnU1Q1VpLz7"
var listaLogin = [""]

    
    struct LogIn : Codable {
        var ident : String!
        var nombre : String!
        var apellidoPat : String!
        var apellidoMat : String!
        var fechaNac : String!
        var email : String!
        var password : String!
    }
    
    struct LogInDr : Codable {
        var identDr : String!
        var nombreDr : String!
        var apellidoPatDr : String!
        var apellidoMatDr : String!
        var fechaNacDr : String!
        var emailDr : String!
        var passwordDr : String!
    }
    



