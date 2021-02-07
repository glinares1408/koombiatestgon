//
//  KoombiaProfilesTTests.swift
//  KoombiaProfilesTTests
//
//  Created by Gonzalo Linares Navarro on 6/02/21.
//

import XCTest
@testable import KoombiaProfilesT

class KoombiaProfilesTTests: XCTestCase {
    
    //First scenario.
    func testPresentAllCourses() {
        
        //Given user open app
        let useCase = HomePostUseCaseMock()
        let viewModel = HomePostViewModelMock(useCase: useCase)
        
        //When user request data
        viewModel.getPosts { (success, error) in
            guard success else { return }
            
            //Then catch data
            XCTAssertGreaterThan(viewModel.homeResponse?.data.count ?? .zero, .zero)
        }
    }
}

class HomePostViewModelMock: InterfaceHomePostsViewModel {
    let useCase: InterfaceHomePostsUseCase
    
    var homeResponse: HomePostsResponse?
    
    required init(useCase: InterfaceHomePostsUseCase) {
        self.useCase = useCase
    }
    
    var homePublication: [HomePostAuxiliar]?
    
    func getPosts(completion: @escaping HomePostsViewModelCompletionClosure) {
        useCase.obtainHomePosts { [weak self] (homeResponse, error) in
            guard let response = homeResponse else {
                completion(false, nil)
                return
            }
            self?.homeResponse = response
            completion(true, error)
        }
    }
    
    func setupImage(path: String, completion: @escaping HomePostSetupImageCompletionClosure) { }
    
    func removeAllData(completion: @escaping HomePostsRemoveAllDataCompletionClosure) { }
}

class HomePostUseCaseMock: InterfaceHomePostsUseCase {
    
    init() { }
    
    required init(repoWeb: InterfaceRepoHomeWeb, repoDataBase: InterfaceRepoDataBase) { }
    
    func obtainHomePosts(completion: @escaping HomePostsUseCaseCompletionClosure) {
        let jsonResponse = self.loadPostsListFromJson()
        completion(jsonResponse, nil)
    }
    
    func removeDataFromDB(completion: @escaping HomePostsDeleteDataCompletionClosure) {
        print("Unused")
    }
    
    private func loadPostsListFromJson() -> HomePostsResponse? {
        let fileName = MockJSONModel.showAllPosts.rawValue
        let posts = UnitTestHelper.decodeJson(fileName: fileName, model: HomePostsResponse.self)
        return posts
    }
}
