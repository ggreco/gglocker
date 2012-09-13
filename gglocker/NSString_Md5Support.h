//
//  NSString_Md5Support_h.h
//  gglocker
//
//  Created by gabry on 9/11/12.
//  Copyright (c) 2012 Gabriele Greco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Support)
- (NSString *) md5;
- (NSString *)encrypt:(NSString *) pwd;
- (NSString *)decrypt:(NSString *) pwd;
@end
