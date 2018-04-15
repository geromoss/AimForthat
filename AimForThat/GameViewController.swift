//
//  ViewController.swift
//  AimForThat
//
//  Created by Gerardo Lupa on 12-04-18.
//  Copyright © 2018 Gerardo Lupa. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentValue : Int = 0
    var targetValue  : Int = 0
    var score        : Int = 0
    var round        : Int = 0
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSlider()
        resetGame()
        updateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(_ sender: UIButton) {
        /*
        var difference : Int = 0
        
        if self.currentValue > self.targetValue{
            difference = self.currentValue - self.targetValue
        }else{
            difference = self.targetValue - self.currentValue
        }
        */
        //otra forma de calcular la diferencia
        let difference : Int = abs(self.currentValue - self.targetValue)
        
        //operador ternario
        var points = (difference > 0) ? 100 - difference : 1000
        
        self.score += points
        
        let title : String
        
        switch difference {
        case 0:
            title = "Puntuacion Perfecta"
        case 1...5:
            title = "Casi perfecto"
            points = Int(1.5 * Float(points))
        case 6...12:
            title = "Te ha faltado poco"
            points = Int(1.2 * Float(points))
        default:
            title = "has ido lejos"
        }
        
        let mensaje = """
        Haz marcado: \(points) puntos
        """
        
        let alert = UIAlertController(title: title, message: mensaje, preferredStyle: .alert)
        //colocar un boton para cerrar el alerta, los actions
        //el handler nil es poner codigo justo cuando tocas el boton, se puede hacer para actualizar datos cuando la persona presiona el boton ok y asi se actualiza recien la informacion y no antes como lo tiene por defecto
        let action = UIAlertAction(title: "Genial", style: .default, handler: {
            //action es quien lo llama una referencia a si misma
            action in
            //colcoar self. para comunicarnos con clases de Viewcontroller ya que todo codigo que este entre las llaves son codigo de UIAlertAction no mas
            self.startNewRound()
            self.updateLabel()
        })
        //vincular el boton al alerta
        alert.addAction(action)
        //para mostrar por pantalla,
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
       
        self.currentValue = Int(sender.value)
        print("el valor del slider es: \(self.currentValue) ")
    }
    
  
    @IBAction func startNewGame(_ sender: UIButton) {
        resetGame()
        updateLabel()
    }
    
    func setupSlider(){
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")   //esto es lo mismo que el UIImage SliderTrack Left anterior
        self.slider.setThumbImage(thumbImageNormal, for: .normal)
        self.slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        //es para alargar la imagen y se extienda, es cortarlo por la mitad y alargar una parte de la imagen
                            //margen 0, un margen de 14 pixeles, margen de 0, abajo margen de 14
    //con eso estamos estirando la zona izquierda  y la zona derecha, es una forma de cortar la imagen y trabajar con ello
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        self.slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        self.slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    func resetGame(){
        self.score = 0
        self.round = 0
        self.startNewRound()
    }
    
    
    func startNewRound(){
        
        self.targetValue = 1 + Int(arc4random_uniform(100)) //genera numeros random de 0 a 99
        self.currentValue = 50
        self.slider.value = Float(self.currentValue)
        self.round += 1
    }
    
    func updateLabel(){
        self.targetLabel.text = "\(self.targetValue)"
        self.scoreLabel.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
    }
    
    
}

