//
//  APIService.swift
//  TSLoan
//
//  Created by Phat Chiem on 9/22/18.
//  Copyright © 2018 Phat. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let apiServiceProvider = MoyaProvider<APIService>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum APIService {
    case offer
    case provinces
    case loans(Loan)
}

extension APIService: TargetType {
    public var baseURL: URL { return URL(string: "https://mockapi.com")! }
    
    public var path: String {
        switch self {
        case .offer:
            return "/offer"
        case .provinces:
            return "/provinces"
        case .loans:
            return "/loans"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .loans:
            return .post
        default:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .loans(let loan):
            return .requestParameters(parameters: loan.toJSON(), encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var validationType: ValidationType {
        return .none
    }
    
    public var sampleData: Data {
        switch self {
        case .offer:
            return JSONUtils.dataFromJSONFile("offer")
        case .provinces:
            return JSONUtils.dataFromJSONFile("provinces")
        case .loans:
            return JSONUtils.dataFromJSONFile("loans")
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
