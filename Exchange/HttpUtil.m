//
//  HttpUtil.m
//  AKB48News
//
//  Created by zhiyu zhang on 12-12-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HttpUtil.h"

@implementation HttpUtil
+(NSString *)post:(NSString *)url
{

    NSMutableDictionary *dlist = [[NSMutableDictionary alloc] init];
    
    
    [dlist setObject:@"value" forKey:@"key"];
    
    NSString *jsonStrPost = [self sendRequestTo:[NSURL URLWithString:url] usingVerb:@"POST" withParameters:dlist];
    //NSLog(@"response: %@", jsonStrPost);
    return jsonStrPost;
}

+(NSString *)sendRequestTo:(NSURL *)url usingVerb:(NSString *)verb withParameters:(NSDictionary *)parameters{
    NSString *jsonStr = nil;
    NSData *body = nil;
    NSMutableString *params = nil;
    NSString *contentType = @"text/html; charset=utf-8";
    NSURL *finalURL = url;
    if(nil != parameters){
        params = [[NSMutableString alloc] init];
        for(id key in parameters){
            NSString *encodedkey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            CFStringRef value = (__bridge CFStringRef)[[parameters objectForKey:key] copy];
            CFStringRef encodedValue = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, value,NULL,(CFStringRef)@";/?:@&=+$", kCFStringEncodingUTF8);
            [params appendFormat:@"%@=%@&", encodedkey, encodedValue];
            CFRelease(value);
            CFRelease(encodedValue);
        }
        [params deleteCharactersInRange:NSMakeRange([params length] - 1, 1)];
    }
    //
    if([verb isEqualToString:@"POST"]){
        contentType = @"application/x-www-form-urlencoded; charset=utf-8";
        body = [params dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        if(nil != parameters){
            NSString *urlWithParams = [[url absoluteString] stringByAppendingFormat:@"?%@", params];
            finalURL = [NSURL URLWithString:urlWithParams];
        }
    }
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    [headers setValue:contentType forKey:@"Content-Type"];
    [headers setValue:@"text/html" forKey:@"Accept"];
    [headers setValue:@"no-cache" forKey:@"Cache-Control"];
    [headers setValue:@"no-cache" forKey:@"Pragma"];
    [headers setValue:@"close" forKey:@"Connection"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:finalURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:verb];
    [request setAllHTTPHeaderFields:headers];
    if(nil != parameters){
        [request setHTTPBody:body];
    }
    params = nil;
    //
    NSURLResponse *response;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error){
        NSLog(@"something is wrong: %@", [error description]);
        return false;
    }else{
        if(responseData){
            jsonStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        }
    }
    return  jsonStr;
}
@end
