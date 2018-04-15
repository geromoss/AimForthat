//
//  AboutUsViewController.swift
//  AimForThat
//
//  Created by Gerardo Lupa on 14-04-18.
//  Copyright © 2018 Gerardo Lupa. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //para acceder un archivo html en local hay que acceder a traves del bundle (paquete
        if let url = Bundle.main.url(forResource: "AimForThat", withExtension: "html"){
            
            if let htmlData = try? Data(contentsOf: url){
                
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                
                self.webView.load(htmlData, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: baseURL)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backPressed(){
        //es el codigo para volver atras, porque si lo hacemos de otra forma con el storyboard de vincular el boton "Volver atras" hacia el storyboard de la vista principal, lo unico que esta haciendo es generar un nuevo viewcontroller y eso significa que genera mas consumo de memoria ram, entonces una forma de usar eficientemente los recursos es colocar en codigo backpress y dentro de ella presenta el dismiss , esta funcion lo que hace es volver hacia la vista anterior, sin generar una vista nuueva, sino que vuelve hacia atras,  entonces usar la tecla control genera un nuevo viewcontroller
        dismiss(animated: true, completion: nil)
        
    }

}
