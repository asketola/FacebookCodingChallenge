// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>

#import <FBSDKCoreKit/FBSDKCopying.h>

/*!
 @abstract A photo for sharing.
 */
@interface FBSDKSharePhoto : NSObject <FBSDKCopying, NSSecureCoding>

/*!
 @abstract Convenience method to build a new photo object with an image.
 @param image If the photo is resident in memory, this method supplies the data
 @param userGenerated Specifies whether the photo represented by the receiver was generated by the user or by the
 application
 */
+ (instancetype)photoWithImage:(UIImage *)image userGenerated:(BOOL)userGenerated;

/*!
 @abstract Convenience method to build a new photo object with an imageURL.
 @param imageURL The URL to the photo
 @param userGenerated Specifies whether the photo represented by the receiver was generated by the user or by the
 application
 */
+ (instancetype)photoWithImageURL:(NSURL *)imageURL userGenerated:(BOOL)userGenerated;

/*!
 @abstract If the photo is resident in memory, this method supplies the data.
 @return UIImage representation of the photo
 */
@property (nonatomic, strong) UIImage *image;

/*!
 @abstract The URL to the photo.
 @return URL that points to a network location or the location of the photo on disk
 */
@property (nonatomic, copy) NSURL *imageURL;

/*!
 @abstract Specifies whether the photo represented by the receiver was generated by the user or by the application.
 @return YES if the photo is user-generated, otherwise NO
 */
@property (nonatomic, assign, getter=isUserGenerated) BOOL userGenerated;

/*!
 @abstract Compares the receiver to another photo.
 @param photo The other photo
 @return YES if the receiver's values are equal to the other photo's values; otherwise NO
 */
- (BOOL)isEqualToSharePhoto:(FBSDKSharePhoto *)photo;

@end
