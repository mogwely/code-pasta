//
//  GithubAPIClient.h
//  CodePasta
//
//  Created by Mohamed Gwely on 23/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface GithubAPIClient : AFHTTPSessionManager


+ (GithubAPIClient *)sharedClient;

- (void)getCodeFileByUrl:(NSString *)url
                       success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
