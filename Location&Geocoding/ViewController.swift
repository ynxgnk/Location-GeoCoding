//
//  ViewController.swift
//  Location&Geocoding
//
//  Created by Nazar Kopeika on 15.05.2023.
//

import CoreLocation /* 35 */
import MapKit /* 1 */
import UIKit

class ViewController: UIViewController {

    private let map: MKMapView = { /* 2 */
        let map = MKMapView() /* 3 */
        return map /* 4 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map) /* 5 */
        title = "Home" /* 33 */
        
        LocationManager.shared.getUserLocation { [weak self] location in /* 25 */
            DispatchQueue.main.async { /* 26 */
                guard let strongSelf = self else { /* 27 */
                    return /* 28 */
                }
                strongSelf.addMapPin(with: location) /* 36 */
            }
        }
    }
    
    override func viewDidLayoutSubviews() { /* 6 */
        super.viewDidLayoutSubviews() /* 7 */
        map.frame = view.bounds /* 8 */
    }
    
    func addMapPin(with location: CLLocation) { /* 34 */
        let pin = MKPointAnnotation() /* 29 */
        pin.coordinate = location.coordinate /* 30 */
        map.setRegion(MKCoordinateRegion(center: location.coordinate,
                                         span: MKCoordinateSpan(latitudeDelta: 0.7,
                                                                longitudeDelta: 0.7
                                                               )
                                        ),
                      animated: true) /* 32 */
        map.addAnnotation(pin) /* 31 */
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in /* 50 */
            self?.title = locationName /* 51 */
        }
    }
}

