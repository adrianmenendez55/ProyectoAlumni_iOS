import UIKit
import MapKit
import CoreLocation
import Alamofire


//
//class LocalizationViewController: UIViewController, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
//
//
//
//    @IBOutlet weak var SearchTableView: UITableView!
//
//    @IBOutlet weak var myImage: UIImageView!
//
//    @IBOutlet weak var homeButton: UIButton!
//
//    @IBOutlet weak var myMapView: MKMapView!
//
//
//
//    @IBOutlet weak var SearchTextField: UITextField!
//
//
//
//    @IBOutlet weak var Prueba: UIButton!
//
//    var matchingItems: [MKMapItem] = [MKMapItem]()
//    var locationManager: CLLocationManager!
//    var id = 0
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        myMapView.delegate = self
//        //SearchTextField.keyboardAppearance = .dark
//
//    }
//
////    override func viewWillAppear(_ animated: Bool) {
////
////        self.resizeTableView()
////        determineCurrentLocation()
////
////    }
////
////    func determineCurrentLocation(){
////
////        locationManager = CLLocationManager()
////        locationManager.delegate = self
////        locationManager.desiredAccuracy = kCLLocationAccuracyBest
////        locationManager.requestAlwaysAuthorization()
////
////
////        if CLLocationManager.locationServicesEnabled() {
////            locationManager.startUpdatingLocation()
////        }
////    }
////
////
////
////
////
////    @IBAction func searchButton(_ sender: Any)
////
////    {
////
////    }
////
////
////
////
////
////    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
////
////    {
////
////        //Ignoring User
////
////        UIApplication.shared.beginIgnoringInteractionEvents()
////
////
////
////        //Activity Indicator
////
////        let activityIndicator = UIActivityIndicatorView()
////
////        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
////
////        activityIndicator.center = self.view.center
////
////        activityIndicator.hidesWhenStopped = true
////
////        activityIndicator.startAnimating()
////
////
////
////        self.view.addSubview(activityIndicator)
////
////
////
////        //Hide search bar
////
////        searchBar.resignFirstResponder()
////        dismiss(animated: true, completion: nil)
////
////
////        //Create the search request
////
////        let searchRequest = MKLocalSearchRequest()
////        searchRequest.naturalLanguageQuery = searchBar.text
////
////        let activeSearch = MKLocalSearch(request: searchRequest)
////        activeSearch.start { (response, error) in
////
////
////
////            activityIndicator.stopAnimating()
////            UIApplication.shared.endIgnoringInteractionEvents()
////
////            if response == nil
////            {
////                print("ERROR")
////            }else{
////
////                //Remove annotations
////
////                let annotations  = self.myMapView.annotations
////                self.myMapView.removeAnnotations(annotations)
////
////
////                //Getting Data
////
////                let latitude = response?.boundingRegion.center.latitude
////
////                let longitude = response?.boundingRegion.center.longitude
////
////
////
////                //Create annotation
////
////                let annotation = MKPointAnnotation()
////
////                annotation.title = searchBar.text
////
////                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
////
////                self.myMapView.addAnnotation(annotation)
////
////
////
////
////
////
////
////
////
////
////
////                //Zooming in on annotation
////
////                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
////
////                let span = MKCoordinateSpanMake(0.01, 0.01)
////
////                let region = MKCoordinateRegionMake(coordinate, span)
////
////                self.myMapView.setRegion(region, animated: true)
////
////
////
////
////
////            }
////
////
////
////        }
////
////    }
////
////    @IBAction func homeScreen(_ sender: Any) {
////
////        dismiss(animated: true, completion: nil)
////
////    }
////
////
////
////    override func didReceiveMemoryWarning() {
////
////        super.didReceiveMemoryWarning()
////
////        // Dispose of any resources that can be recreated.
////
////    }
////
////
////
////    func see(){
////
////
////
////        /* init?(json: [Any]) {
////
////         // 1
////
////         self.title = json[16] as? String ?? "No Title"
////
////         self.locationName = json[12] as! String
////
////         self.discipline = json[15] as! String
////
////         // 2
////
////         if let latitude = Double(json[18] as! String),
////
////         let longitude = Double(json[19] as! String) {
////
////         self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
////
////         } else {
////
////         self.coordinate = CLLocationCoordinate2D()
////
////         }
////
////         }*/
////
////
////
////    }
////
////
////
////    func addAnnotation(sender:UILongPressGestureRecognizer){
////
////
////
////        dismiss(animated: true, completion: nil)
////
////    }
////
////    /*
////
////     // MARK: - Navigation
////
////
////
////     // In a storyboard-based application, you will often want to do a little preparation before navigation
////
////     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////
////     // Get the new view controller using segue.destinationViewController.
////
////     // Pass the selected object to the new view controller.
////
////     }
////
////     */
////
////
////
////
////
////    // 1
////
////    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
////
////        // 2
////
////        let identifier = "myPin"
////
////        var view: MKPinAnnotationView
////
////        if let annotation = annotation as? MapElement {
////
////            if let dqView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
////
////                view = dqView
////
////                return view
////
////            } else {
////
////                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
////
////                view.isEnabled = true
////
////                view.canShowCallout = true
////
////                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
////
////                view.tag = 18
////
////                view.pinTintColor = .blue
////
////                return view
////
////            }
////
////        }
////
////
////
////        return nil
////
////    }
////
////
////
////
////
////    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
////
////                 calloutAccessoryControlTapped control: UIControl) {
////
////        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailEventViewController") as! DetailEventViewController
////
////
////
////        self.present(vc, animated: true, completion: nil)
////
////    }
////
////
////
////
////
////
////
////    // MARK:- TableView Settings
////
////    func numberOfSections(in tableView: UITableView) -> Int {
////
////        return 1
////
////    }
////
////
////
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////
////        print(matchingItems.count)
////
////        return matchingItems.count
////
////    }
////
////
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////
////
////        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
////
////        cell.textLabel?.text = matchingItems[indexPath.row].name
////
////        return cell
////
////
////
////    }
////
////
////
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////
////        self.myMapView.removeAnnotations(self.myMapView.annotations )
////
////
////
////        let item = matchingItems[indexPath.row]
////
////        print("-aaaaa---------------------------------->")
////
////        print(item)
////
////        print("<aaaaaa----------------------------------")
////
////        let annotation =  MapElement(title: item.name!, locationName: "", discipline: "", coordinate: CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude))
////
////
////
////        //annotation.coordinate = item.placemark.coordinate
////
////        // annotation.title = item.name
////
////
////
////
////
////        self.myMapView.addAnnotation(annotation)
////
////
////
////        matchingItems.removeAll()
////
////        self.resizeTableView()
////
////
////
////        let center = CLLocationCoordinate2D(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
////
////
////
////        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
////
////        myMapView.setRegion(region, animated: true)
////
////
////
////        let url = URL(string:"http://h2744356.stratoserver.net/shigui/Shigui/public/index.php/places/create.json")
////
////        let parameters: Parameters = [
////
////            "name": item.placemark.name!,
////
////            "id_maps":"\(item.placemark.coordinate.latitude)\(item.placemark.coordinate.longitude)",
////
////            "coordinates_X": item.placemark.coordinate.latitude,
////
////            "coordinates_Y": item.placemark.coordinate.longitude,
////
////
////
////            ]
////
////
////
////        //peticion = "RegisterRequest"
////
////        //func miLlamada(url, parameters, tipo, peticion)
////
////
////
////        Alamofire.request(url!, method: .post, parameters: parameters).responseJSON{ response in
////
////
////
////            print("(--------------------------")
////
////            print("Request        :: \(response.request)")
////
////            print("Request Result :: \(response.result)")
////
////            print("Request Value  :: \(response.result.value)")
////
////            print("Request StatusCode :: \(response.response?.statusCode)")
////
////
////
////            switch response.result {
////
////
////
////            case .success:
////
////
////
////                print("La peticion ha ido bien")
////
////                let json = response.result.value as! Dictionary<String, Any>
////
////                let myCode = json["code"] as! Int
////
////                switch myCode {
////
////                case 200:
////
////                    eventObject = json["data"]  as! Dictionary<String, Any>
////
////                    //self.id = json["id"] as! Int
////
////                    //print("\(json["data"] as! String)")
////
////
////
////
////
////
////
////
////
////                    // showAlert(json["message"])
////
////                    // Accion de login -> Guardar en defaults -> Controller
////
////                    // case 400:
////
////                    //     print("Han habido error")
////
////                default:
////
////                    eventObject = json["data"]  as! Dictionary<String, Any>
////
////                }
////
////
////
////            case .failure:
////
////                print("La peticion no ha funcionado")
////
////            }
////
////        }
////
////
////
////
////
////
////
////    }
////
////
////
////    @IBAction func searchChanges(_ sender: UITextField) {
////
////
////
////        matchingItems.removeAll()
////
////        self.myMapView.removeAnnotations(self.myMapView.annotations )
////
////        if sender.text!.count >= 3 {
////
////            searchItems(searchField:  sender.text!)
////
////        } else {
////
////            self.resizeTableView()
////
////        }
////
////    }
////
////
////
////    @IBAction func textFieldShouldReturn(_ textField: UITextField)  {   //
////
////        textField.resignFirstResponder()
////
////    }
////
////
////
////    func searchItems(searchField: String){
////
////
////
////        let request = MKLocalSearchRequest()
////
////        request.naturalLanguageQuery = searchField
////
////        request.region = myMapView.region
////
////        let search = MKLocalSearch(request: request)
////
////        search.start(completionHandler: {(response, error) in
////
////            if error != nil {
////
////                print("Error in search:\(error!.localizedDescription)")
////
////            } else if response!.mapItems.count == 0 {
////
////                print("No hay coincidencias")
////
////            } else {
////
////                print("HAY COINCIDENCIAS -------------------------------->")
////
////                // print(response!.mapItems)
////
////
////
////
////
////
////
////
////
////                for item in response!.mapItems {
////
////                    //self.SearchTableView.reloadData()
////
////                    self.matchingItems.append(item as MKMapItem)
////
////                    let annotation = MKPointAnnotation()
////
////                    annotation.coordinate = item.placemark.coordinate
////
////                    annotation.title = item.name
////
////                    self.myMapView.addAnnotation(annotation)
////
////                }
////
////                print("MatchingItems = \(self.matchingItems.count)")
////
////                DispatchQueue.main.async {
////
////                    self.resizeTableView()
////
////                }
////
////
////
////
////
////            }
////
////        })
////
////
////
////
////
////    }
////
////
////
////    func resizeTableView(){
////
////        print("REPINTO")
////
////        SearchTableView.reloadData()
////
////        var tableFrame = SearchTableView.frame
////
////        tableFrame.size.height = SearchTableView.contentSize.height
////
////        SearchTableView.frame = tableFrame
////
////    }
////
////
////
////
////
////
////
////    // MARK:- LOCATION MANAGER
////
////
////
////    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////
////        let userLocation: CLLocation = locations[0] as CLLocation
////
////        locationManager.stopUpdatingLocation()
////
////        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
////
////        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
////
////        myMapView.setRegion(region, animated: true)
////
////
////
////        //        let userAnnotation : MKPointAnnotation = MKPointAnnotation()
////
////        //        userAnnotation.coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
////
////        //        userAnnotation.title = "Current location"
////
////        //        myMapView.addAnnotation(userAnnotation)
////
////    }
////
////
////
////
//
//}
//
//
//
//
