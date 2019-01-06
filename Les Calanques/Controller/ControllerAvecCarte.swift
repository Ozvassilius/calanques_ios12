//
//  ControllerAvecCarte.swift
//  Les Calanques
//
//  Created by Macinstosh on 05/01/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit
import MapKit

class ControllerAvecCarte: UIViewController, MKMapViewDelegate {
    
    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // var
    var calanques : [Calanque] = CalanqueCollection().all()
    
    // pour passer au detail
    //////////////////////////
    func toDetail(calanque: Calanque) {
        performSegue(withIdentifier: "Detail", sender: calanque)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let controller = segue.destination as? DetailController {
                controller.calanqueRecue = sender as? Calanque
            }
        }
    }
    /////////////////////////
    
    func addAnnotations() {
        for calanque in calanques {
            
            
            let annotation = MonAnnotation(calanque)
            mapView.addAnnotation(annotation)
            
            // annotation de base (sans le mode MonAnnotation
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = calanque.coordonnee
//            annotation.title = calanque.nom
//            mapView.addAnnotation(annotation)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        addAnnotations()
        
    }
    
    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: mapView.mapType = MKMapType.standard
        case 1: mapView.mapType = .satellite
        case 2: mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    @IBAction func getPosition(_ sender: Any) {
    }
   
    
    // Delegate de MapKit
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "reuseID"
        
        // verifier que ce soit pas la position de l'utilisateur
        if annotation.isKind(of: MKUserLocation.self) { return nil }
        
        // verifier si le parametre recu annotation est de type MonAnnotation
        // on cree une variable pour dequeue, pour pas surcharger la memoire
        // comme pour les tableView
        if let anno = annotation as? MonAnnotation {
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            
            if annotationView == nil { // si l'annotation n'est pas encore crée
                
                annotationView = MonAnnotationView(controller: self, annotation: anno, reuseIdentifier: reuseIdentifier)
                
              // methode avec l'ancien init (sans le controller qui permet de faire le segue
              //  annotationView = MonAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                
                // Methode de base
//                annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
//                annotationView?.image = UIImage(named: "placeholder" )
//                annotationView?.canShowCallout = true // bulle
                return annotationView
            } else { // cas ou elle est deja crée
                return annotationView
            }
        }
        return nil
    }
    
}
