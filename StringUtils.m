//
//  StringUtils.m
//  movies
//
//  Created by Kyle Smith on 4/7/16.
//  Copyright © 2016 Kyle Smith. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

- (NSString* )stringByRemovingControlCharacters: (NSString *)inputString
{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputString rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound) {
        NSMutableString *mutable = [NSMutableString stringWithString:inputString];
        while (range.location != NSNotFound) {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputString;
}

@end
