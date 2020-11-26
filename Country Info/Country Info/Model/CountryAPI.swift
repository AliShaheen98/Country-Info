
import Foundation

protocol CountryAPIDelegate {
    func didReteriveCountryInfo(country : Country)
}
class CountryAPI{
    
    var delegate: CountryAPIDelegate?
    let urlBaseString = "https://restcountries.eu/rest/v2/name/"
    
    func fetchData(countryName:String){
        let urlString = "\(urlBaseString)\(countryName)"
        //1. Create URl
        if let url = URL(string: urlString){
        //2. Create URLSession
        let session = URLSession(configuration: .default)
        //3. Create Task
        let task = session.dataTask(with: url, completionHandler: taskHandler(data:urlResponse:error:))
        //4. Start Task
        task.resume()
        
        }
        else{
            print("Error")
        }
    
        
    }
    func taskHandler(data: Data? ,urlResponse: URLResponse?,error: Error? ) -> Void {
        do{
            let Countries: [Country] = try JSONDecoder().decode([Country].self, from: data!)
            let firstCountry = Countries[0]
            delegate?.didReteriveCountryInfo(country: firstCountry)

        }
        catch{
            print(error)
        }

    }
}

 
