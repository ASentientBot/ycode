@class WindowController;

@interface Document:NSDocument

@property NSURL* cachedURL;
@property WindowController* windowController;

@end

#import "Document.m"