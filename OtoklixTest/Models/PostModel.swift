import Foundation

struct PostModel: Decodable {
    var id: Int?
    var title, content, publishedAt, createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content
        case publishedAt = "published_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
