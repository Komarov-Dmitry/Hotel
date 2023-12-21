import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchData(from url: URL, completion: @escaping (Result<ModelHotel, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let hotelData = try decoder.decode(ModelHotel.self, from: data)
                    completion(.success(hotelData))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

}

enum NetworkError: Error {
    case invalidResponse
}

