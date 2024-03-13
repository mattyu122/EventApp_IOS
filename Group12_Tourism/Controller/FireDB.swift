import FirebaseFirestore

class FireDB:ObservableObject {
    static let shared = FireDB()
    
    let db = Firestore.firestore()

    private init(){}
}
