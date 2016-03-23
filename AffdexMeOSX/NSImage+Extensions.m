//
//  NSImage+Extensions.m
//  AffdexMe
//
//  Created by Boisy Pitre on 3/18/16.
//  Copyright © 2016 tee-boy. All rights reserved.
//

#import "NSImage+Extensions.h"

@implementation NSImage (Extensions)

+ (NSImage *)imageFromText:(NSString *)text size:(CGFloat)size;
{
    NSImage *image = nil;

    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [NSFont systemFontOfSize:80.0]}];
    
    NSSize boxSize = [attributedString size];
    NSRect rect = NSMakeRect(0.0, 0.0, boxSize.width, boxSize.height);
    image = [[NSImage alloc] initWithSize:boxSize];
    
    [image lockFocus];
    
    [[NSColor clearColor] set];
    NSRectFill(rect);
    
    [attributedString drawInRect:rect];

    [image unlockFocus];
    
    return image;
}

+ (NSImage *)imageFromView:(NSView *)view withSize:(CGSize)size;
{
    NSSize mySize = view.bounds.size;
    NSSize imgSize = NSMakeSize( mySize.width, mySize.height );
    
    NSBitmapImageRep *bir = [view bitmapImageRepForCachingDisplayInRect:[view bounds]];
    [bir setSize:imgSize];
    [view cacheDisplayInRect:[view bounds] toBitmapImageRep:bir];
    
    NSImage* image = [[NSImage alloc]initWithSize:imgSize];
    [image addRepresentation:bir];
    return image;
}

+ (NSImage *)imageFromView:(NSView *)view
{
    return [NSImage imageFromView:view withSize:view.bounds.size];
}

- (NSImage *)drawImages:(NSArray *)inputImages inRects:(NSArray *)frames;
{
    NSImage *newImage = nil;
    
#if 0
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)];
    NSUInteger inputImagesCount = [inputImages count];
    NSUInteger framesCount = [frames count];
    if (inputImagesCount == framesCount) {
        for (int i = 0; i < inputImagesCount; i++) {
            NSImage *inputImage = [inputImages objectAtIndex:i];
            CGRect frame = [[frames objectAtIndex:i] CGRectValue];
            [inputImage drawInRect:frame];
        }
    }
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
#endif
    
    return newImage;
}

@end
