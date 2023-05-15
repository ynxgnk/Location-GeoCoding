//
//  LocationManager.swift
//  Location&Geocoding
//
//  Created by Nazar Kopeika on 15.05.2023.
//

import CoreLocation /* 11 */
import Foundation
 
class LocationManager: NSObject, CLLocationManagerDelegate { /* 9 */ /* 17 add 2 protocols */
    static let shared = LocationManager() /* 10 */
    
    let manager = CLLocationManager() /* 12 */
    
    var completion: ((CLLocation) -> Void)? /* 22 */
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) { /* 13 */
        self.completion = completion /* 21 */
        manager.requestWhenInUseAuthorization() /* 14 */
        manager.delegate = self /* 15 */
        manager.startUpdatingLocation() /* 16 */
    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) { /* 37 */
        let geocoder = CLGeocoder() /* 38 */
        geocoder.reverseGeocodeLocation(location,
                                        preferredLocale: .current) { placemarks, error in /* 39 */
            guard let place = placemarks?.first, error == nil else { /* 40 */
                completion(nil) /* 42 */
                return /* 41 */
            }
            
            print(place) /* 43 */
            
            var name = "" /* 44 */
            if let locality = place.locality  { /* 45 */
                name += locality /* 46 */
            }
            
            if let adminRegion = place.administrativeArea { /* 47 */
                name += ",  \(adminRegion)" /* 48 */
            }
            
            completion(name) /* 49 */
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { /* 18 */
        guard let location = locations.first else { /* 19 */
            return /* 20 */
        }
        completion?(location) /* 23 */
        manager.stopUpdatingLocation() /* 24 */
    }
}
