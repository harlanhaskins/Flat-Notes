@interface UIImage(Color)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@implementation UIImage(Color)

+ (UIImage*) imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, 1, 1);

    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end

@interface NotesTextureBackgroundView

+ (UIImage*) textureImage;

@end

%hook NotesTextureBackgroundView

+ (UIImage*) statusBarBackgroundImage {

    // Create a blank, white image for the background.
    return [%c(NotesTextureBackgroundView) textureImage];
}

+ (UIImage*) textureImage {

    // Create a blank, white image for the background.
    return [UIImage imageWithColor:[UIColor whiteColor]];
}

%end

%hook NoteCellContentView

- (void) setTitle:(NSString*)title {
    
    // Hook the useLetterpress variable and set it to NO.
    BOOL &useLetterpress = MSHookIvar<BOOL>(self, "_useLetterpress");
    useLetterpress = NO;
    
    %orig(title);
}

- (void) setDate:(NSDate*)date {
    
    // Hook the useLetterpress variable and set it to NO.
    BOOL &useLetterpress = MSHookIvar<BOOL>(self, "_useLetterpress");
    useLetterpress = NO;
    
    %orig(date);
}

%end

%hook NotesApp

- (void) _configureBarLetterpress:(UINavigationBar*)navigationBar {
    // We don't ever want this to run. No sir.
    return;
}

%end
