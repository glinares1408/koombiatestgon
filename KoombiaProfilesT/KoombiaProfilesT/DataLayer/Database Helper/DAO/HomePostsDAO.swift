//
//  HomePostsDAO.swift
//  KoombiaProfilesT
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import Foundation
import CouchbaseLiteSwift

typealias HomePostsDAOInsertCompletionClosure = (_ sucess: Bool, _ error: Error?) -> Void
typealias HomePostsDAOReading = (_ homePosts: HomePostsResponse?, _ error: Error?) -> Void

enum HomePostsDAOError: Error {
    case databaseProblem
    case encodeProblem
    case writing
    case fetching
}

class HomePostsDAO {
    
    var myId: String?
    
    func insertHomePosts(homePostResponse: HomePostsResponse, completion: @escaping HomePostsDAOInsertCompletionClosure) {
        guard let database = HomePostsDatabase.shared.database else {
            completion(false, HomePostsDAOError.databaseProblem)
            return
        }
        
        guard let data = try? JSONEncoder().encode(homePostResponse) else {
            completion(false, HomePostsDAOError.encodeProblem)
            return
        }
        
        let finalString = String(data: data, encoding: String.Encoding.utf8)
        
        let mutableDocument = MutableDocument().setFloat(2.0, forKey: "version").setString("homeposts2", forKey: "type").setString(finalString, forKey: "type2")
        
        myId = mutableDocument.id
        
        guard let _ = try? database.saveDocument(mutableDocument) else {
            completion(false, HomePostsDAOError.writing)
            return
        }
        
        completion(true, nil)
    }
    
    func fetchHomePosts(completion: @escaping HomePostsDAOReading) {
        guard let database = HomePostsDatabase.shared.database else {
            completion(nil, HomePostsDAOError.databaseProblem)
            return
        }
        
        let query = QueryBuilder.select(SelectResult.all()).from(DataSource.database(database)).where(Expression.property("type").equalTo(Expression.string("homeposts2")))

        
        do {
            let result5 = try query.execute()
            print(result5.allResults().count)

            for result in try query.execute() {
                print(result)
            }
        } catch {
            fatalError("Error during the query")
        }
        
        completion(nil, nil)
    }
}
