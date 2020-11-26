
import UIKit
import CoreLocation
class ViewController: UIViewController{


    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        countryAPI.delegate = self
        locationManger.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    var locationManger = CLLocationManager()
    var geoCoder = CLGeocoder()
    var countryAPI = CountryAPI()
    


    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        updateUI()
        
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestAlwaysAuthorization()
        locationManger.requestLocation()
    }
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    
    func updateUI(){
        countryAPI.fetchData(countryName: searchTextField.text!)

    }
    
    }
extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return Key Was Pressed")
        updateUI()
        return true
    }
}
extension ViewController : CountryAPIDelegate{
    func didReteriveCountryInfo(country: Country) {
        DispatchQueue.main.async {
            self.countryLabel.text = country.name
            self.capitalLabel.text = country.capital
            self.regionLabel.text = country.region
            self.populationLabel.text = String(country.population)
        }
    
    }
}

extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        geoCoder.reverseGeocodeLocation(location!) { (Places, error) in
//            print(Places?.last?.isoCountryCode)
//            print(Places?.last?.country)
          let  cName = Places?.last?.country!
            self.countryAPI.fetchData(countryName: cName!)
            
        }
        


    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

