import Foundation

struct ModelHotel: Decodable {
    let id: Int
    let name: String
    let adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: [String]
    let aboutTheHotel: AboutTheHotel

    enum CodingKeys: String, CodingKey {
        case id, name, adress = "adress", minimalPrice = "minimal_price", priceForIt = "price_for_it", rating, ratingName = "rating_name", imageUrls = "image_urls", aboutTheHotel = "about_the_hotel"
    }
}

struct AboutTheHotel: Decodable {
    let aboutTheHotelDescription: String
    let peculiarities: [String]

    enum CodingKeys: String, CodingKey {
        case aboutTheHotelDescription = "description", peculiarities
    }
}
