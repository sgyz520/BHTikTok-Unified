//
//  BHDownload.m
//  DIYTableView
//
//  Created by BandarHelal on 12/01/1442 AH.
//  Copyright © 1442 BandarHelal. All rights reserved.
//

#import "BHDownload.h"

@implementation BHDownload
- (instancetype)init {
    self = [super init];
    if (self) {
        self.Session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

- (void)downloadFileWithURL:(NSURL *)url {
    if (url) {
        self.fileName = url.absoluteString.lastPathComponent;
        NSURLSessionDownloadTask *downloadTask = [self.Session downloadTaskWithURL:url];
        [downloadTask resume];
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float prog = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
    if (self.delegate && [self.delegate respondsToSelector:@selector(downloadProgress:)]) {
        [self.delegate downloadProgress:prog];
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    if (self.delegate && [self.delegate respondsToSelector:@selector(downloadDidFinish:Filename:)]) {
        [self.delegate downloadDidFinish:location Filename:self.fileName];
    }
}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(downloadDidFailureWithError:)]) {
        [self.delegate downloadDidFailureWithError:error];
    }
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error && self.delegate && [self.delegate respondsToSelector:@selector(downloadDidFailureWithError:)]) {
        [self.delegate downloadDidFailureWithError:error];
    }
}
@end