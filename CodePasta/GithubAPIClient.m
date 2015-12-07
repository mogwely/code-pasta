//
//  GithubAPIClient.m
//  CodePasta
//
//  Created by Mohamed Gwely on 23/10/15.
//  Copyright (c) 2015 Mohamed Gwely. All rights reserved.
//

#import "GithubAPIClient.h"
#import "Constants.h"

@implementation GithubAPIClient

+ (GithubAPIClient *)sharedClient {
    static GithubAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString: GITHUB_BASE_URL_STRING]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (!self) {
        return nil;
    }
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[requestSerializer setValue:@"application/vnd.github.v3.raw+json" forHTTPHeaderField:@"Accept"];
    
    self.requestSerializer = requestSerializer;
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return self;
}

- (void)getCodeFileByUrl:(NSString *)url
                  success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                  failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    //escapes special characters
    url = [url stringByReplacingOccurrencesOfString:@"blob/master"
                                               withString:@"contents"];
    NSArray *arrayWithTwoStrings = [url componentsSeparatedByString:@"github.com/"];
    NSString* urlWithoutPrefix = arrayWithTwoStrings[1];
    //NSString* escapedUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    //NSString *pageString = [NSString stringWithFormat: @"%ld", (long)page];
    
    NSString* path = [NSString stringWithFormat:@"repos/%@",urlWithoutPrefix];
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            
            success(task, responseObject);
            NSLog(@"%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}




@end