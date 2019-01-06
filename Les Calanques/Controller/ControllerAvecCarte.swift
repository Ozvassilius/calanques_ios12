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
        
        // notif: etape 2 on observe dans le viewDidLoad les notifs qui tournent
        // et on applique une fonction en consequence
        NotificationCenter.default.addObserver(self, selector:#selector(notifDetail), name: Notification.Name("DetailNotifName"), object:nil)
        
        // reglages de la hauteut (delta) de la map
        // voir fonction setupMap
        if calanques.count > 5 {
            let premiere = calanques[5].coordonnee
            setupMap(coordonnees: premiere)
        }
        
    }
    
    func setupMap(coordonnees: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.35, longitudeDelta: 0.35)
        let region = MKCoordinateRegion(center: coordonnees, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // notif: etape 3 on applique la fonction voulue
    @objc func notifDetail(notification: Notification) {
    if let calanque = notification.object as? Calanque {
    print("J'ai une calanque")
    toDetail(calanque: calanque)
    }
    
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
