//
//  paintFuncs.m
//  Rotation
//
//  Created by Fan Yang on 2018/6/4.
//  Copyright © 2018年 byteD. All rights reserved.
//
#import <OpenGLES/ES3/gl.h>  //glXXX etc.
#import <OpenGLES/ES3/glext.h>  //extensions
#define GLES_VERSION 3

#import <UIKit/UIKit.h>
#import "myView.h"

#define TEX_COORD_MAX   1

/////-square
typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2]; // New
} Vertex;




///////pkm header
struct __attribute__((__packed__)) PKMHeader {
    struct u16be {
        uint8_t msb, lsb;
        inline uint16_t value() const{
            return msb << 8 | lsb;
        }
    };
    
    char    magicNumber[4];   //"PKM "
    u16be   version;                //"10" or "20"
    u16be   format;                 //0~8
    u16be   paddedWidth;
    u16be   paddedHeight;
    u16be   width;
    u16be   height;
};

////////pkm header funcs
unsigned short getWidth(const PKMHeader &p)
{
    return p.width.value();
}

unsigned short getHeight(const PKMHeader &p)
{
    return p.height.value();
}

unsigned short getPaddedWidth(const PKMHeader &p)
{
    return p.paddedWidth.value();
}

unsigned short getPaddedHeight(const PKMHeader &p)
{
    return p.paddedHeight.value();
}

GLenum getInternalFormat(const PKMHeader &p)
{
    unsigned short format = p.format.value();
    switch (format) {
//        case 0:
//            return GL_ETC1_RGB8_OES;
//            break;
        case 1:
            return GL_COMPRESSED_RGB8_ETC2;
            break;
        case 3:
            return GL_COMPRESSED_RGBA8_ETC2_EAC;
            break;
        case 4:
            return GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2;
            break;
        case 5:
            return GL_COMPRESSED_R11_EAC;
            break;
        case 6:
            return GL_COMPRESSED_RG11_EAC;
            break;
        case 7:
            return GL_COMPRESSED_SIGNED_R11_EAC;
            break;
        case 8:
            return GL_COMPRESSED_SIGNED_RG11_EAC;
            break;
        default:
            NSLog(@"Unsupported format! %d", format);
            exit(1);
            break;
    }
}

#if GLES_VERSION == 2
GLsizei getSize(const PKMHeader &p)
{
    return (getPaddedWidth(p) * getPaddedHeight(p));
}
#elif GLES_VERSION == 3
GLsizei getSize(const PKMHeader &p)
{
    GLenum internalFormat = getInternalFormat(p);
    if (internalFormat != GL_COMPRESSED_RG11_EAC       && internalFormat != GL_COMPRESSED_SIGNED_RG11_EAC &&
        internalFormat != GL_COMPRESSED_RGBA8_ETC2_EAC && internalFormat != GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC)
    {
        return (getPaddedWidth(p) * getPaddedHeight(p)) >> 1;
    }
    else
    {
        return (getPaddedWidth(p) * getPaddedHeight(p));
    }
}
#endif
//////////////////////////////



const Vertex Vertices[] = {
    // Front
    {{1, -1, 1}, {5, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, 1}, {5, 0, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, 1}, {5, 0, 0, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, 1}, {5, 0, 0, 1}, {0, 0}},
    // Back
    {{1, 1, -1}, {0, 5, 0, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -1}, {0, 5, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, -1, -1}, {0, 5, 0, 1}, {0, 0}},
    {{-1, 1, -1}, {0, 5, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    // Left
    {{-1, -1, 1}, {0, 0, 5, 1}, {TEX_COORD_MAX, 0}},
    {{-1, 1, 1}, {0, 0, 5, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -1}, {0, 0, 5, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -1}, {0, 0, 5, 1}, {0, 0}},
    // Right
    {{1, -1, -1}, {5, 5, 5, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, -1}, {5, 5, 5, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, 1, 1}, {5, 5, 5, 1}, {0, TEX_COORD_MAX}},
    {{1, -1, 1}, {5, 5, 5, 1}, {0, 0}},
    // Top
    {{1, 1, 1}, {5, 5, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, -1}, {5, 5, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -1}, {5, 5, 0, 1}, {0, TEX_COORD_MAX}},
    {{-1, 1, 1}, {5, 5, 0, 1}, {0, 0}},
    // Bottom
    {{1, -1, -1}, {0, 1, 1, 1}, {TEX_COORD_MAX, 0}},
    {{1, -1, 1}, {0, 255, 2555, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, -1, 1}, {0, 127, 127, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -1}, {0, 63, 63, 1}, {0, 0}}
};

const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 5, 6,
    4, 5, 7,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

@implementation GLView : UIView
+ (Class)layerClass {
    return [CAEAGLLayer class];
} //overwrite func layerClass

- (void)setupLayer {
    // 用于显示的CAEAGLlayer
    _eaglLayer = (CAEAGLLayer *)self.layer;
    
    // CALayer 默认是透明的（opaque = NO），而透明的层对性能负荷很大。所以将其关闭。
    _eaglLayer.opaque = YES;
}

- (void)setupContext {
    if (!_context) {
        // 创建GL环境上下文
        // EAGLContext 管理所有通过 OpenGL ES 进行渲染的信息.
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    }
    
    NSAssert(_context && [EAGLContext setCurrentContext:_context], @"初始化GL环境失败");  //setCurrentContext
}

- (void)setupRenderBuffer {
    // 生成 renderbuffer ( renderbuffer = 用于展示的窗口 )
    glGenRenderbuffers(1, &_colorrenderbuffer);
    // 绑定 renderbuffer
    glBindRenderbuffer(GL_RENDERBUFFER, _colorrenderbuffer);
    // GL_RENDERBUFFER 的内容存储到实现 EAGLDrawable 协议的 CAEAGLLayer
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

- (void)setupDepthBuffer {
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
}

- (void)setupFrameBuffer {
    glGenFramebuffers(1, &_framebuffer);
    // 设置为当前 framebuffer
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    // 将 _colorRenderBuffer 装配到 GL_COLOR_ATTACHMENT0 这个装配点上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, _colorrenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}
- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &_framebuffer);
    _framebuffer = 0;
    glDeleteRenderbuffers(1, &_colorrenderbuffer);
    _colorrenderbuffer = 0;
}

- (void)setupProjection{

    _aspect = self.frame.size.width / self.frame.size.height;
    _sightAngleY = 60; //view y angle in degrees
    _nearZ = 1.0f;
    _farZ = 1000.0f;
}

//init transform matrix
- (void)setupTransform{
    _posX = 0.0;
    _posY = 0.0;
    _posZ = 0.0;
    
    _rotateX = 0.0;
    _rotateY = 0.0;
    _rotateZ = 0.0;
    _angle = 0.0;
    
    scaleX = 1.0;
    scaleY = 1.0;
    scaleZ = 1.0;
}
- (GLuint)setupTexture:(NSString *)fileName {
//    // 1) Get Core Graphics image reference. As you can see this is the simplest step. We just use the UIImage imageNamed initializer I’m sure you’ve seen many times, and then access its CGImage property.
//    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
//    if (!spriteImage) {
//        NSLog(@"Failed to load image %@", fileName);
//        exit(1);
//    }
//
//    // 2) Create Core Graphics bitmap context. To create a bitmap context, you have to allocate space for it yourself. Here we use some function calls to get the width and height of the image, and then allocate width*height*4 bytes.
//    //    “Why times 4?” you may wonder. When we call the method to draw the image data, it will write one byte each for red, green, blue, and alpha – so 4 bytes in total.
//    //    “Why 1 byte per each?” you may wonder. Well, we tell Core Graphics to do this when we set up the context. The fourth parameter to CGBitmapContextCreate is the bits per component, and we set this to 8 bits (1 byte).
//    size_t width = CGImageGetWidth(spriteImage);
//    size_t height = CGImageGetHeight(spriteImage);
//
//    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
//
//    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
//                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
//
//    // 3) Draw the image into the context. This is also a pretty simiple step – we just tell Core Graphics to draw the image at the specified rectangle. Since we’re done with the context at this point, we can release it.
//    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
//
//    CGContextRelease(spriteContext);
//
//    // 4) Send the pixel data to OpenGL. We first need to call glGenTextures to create a texture object and give us its unique ID (called “name”).
//    GLuint texName;
//    glGenTextures(1, &texName);
//    glBindTexture(GL_TEXTURE_2D, texName);
//
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
//
//    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (int)width, (int)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
//
//    free(spriteData);
//    return texName;
    ///////////////////////////////////load compressed texture///////////
    
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    NSUInteger len = [data length];
    NSLog(@"file len %u", len);
    Byte *byteData = (Byte*)malloc(len);
    if(byteData == nullptr){
        NSLog(@"can't alloc memery for compressed image!");
        exit(1);
    }
    memcpy(byteData, [data bytes], len);
    
    const PKMHeader &p = *reinterpret_cast<const PKMHeader *>(byteData);
    
    NSLog(@"width %d, height %d, size %d, internal format %x", getWidth(p), getHeight(p), getSize(p), getInternalFormat(p));


    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    
    glCompressedTexImage2D(GL_TEXTURE_2D, 0, getInternalFormat(p), getWidth(p), getHeight(p), 0, getSize(p), (GLubyte*)byteData);
    NSLog(@"test %x", glGetError());
    
    free(byteData);
    return texName;

    

}

- (void)setup {
    [self setupLayer];
    [self setupContext];
    
    [self destoryRenderAndFrameBuffer];
    
    [self setupDepthBuffer];
    [self setupRenderBuffer];
    [self setupFrameBuffer];
    
    [self compileShaders];
    
    [self setupVBOs];   //setup VBOs and push data, then bind them to VAOs
    [self setupVAO];

    [self setupProjection];
    [self setupTransform];
    NSLog(@"test %x", glGetError());

    _myTexture = [self setupTexture:@"/Users/yangfan/Code/Git/OpenGL_Rotation/Rotation/test.pkm"];
    
}

/////////----shader
- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {
    
    // 获取装有文件内容的NSString
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName
                                                           ofType:@"glsl"];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath
                                                       encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    // call glCreatShader func to creat a OpenGL object to represent the shade(according to shaderType)
    GLuint shaderHandle = glCreateShader(shaderType);
    
    // convert NSString to C-String and give OpenGL source code of this shader
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength =(int) [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
    
    // calls glCompileShader to compile the shader at runtime!
    glCompileShader(shaderHandle);
    
    // test
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    return shaderHandle;
}

- (void)compileShaders {
    
    // 使用上面的方法来编译两个shader
    GLuint vertexShader = [self compileShader:@"SimpleVertex"
                                     withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:@"SimpleFragment"
                                       withType:GL_FRAGMENT_SHADER];
    
    // 调用接下来的func来创建和将shader们连接到program。当链接着色器至一个程序的时候，它会把每个着色器的输出链接到下个着色器的输入。当输出和输入不匹配的时候，会得到一个链接错误
    _programHandle = glCreateProgram();
    glAttachShader(_programHandle, vertexShader);
    glAttachShader(_programHandle, fragmentShader);
    glLinkProgram(_programHandle);
    
    // check
    GLint linkSuccess;
    glGetProgramiv(_programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }
    
    // 得到着色器程序对象后，我们可以调用 glUseProgram 函数，用刚创建的程序对象作为它的参数，以激活这个程序对象。
    // 告诉OpenGL在获得顶点信息后，调用刚才的程序来处理
    glUseProgram(_programHandle);
    
    // 调用glGetAttribLocatuon来获取顶点着色器输入的入口，以便加入代码。同时调用glEnableVertexAttribArray方法，以顶点属性值作为参数，启用顶点属性（顶点属性默认是禁用的）。
    _positionSlot = glGetAttribLocation(_programHandle, "Position");
    _colorSlot = glGetAttribLocation(_programHandle, "SourceColor");

    //texture
    _texCoordSlot = glGetAttribLocation(_programHandle, "TexCoordIn");
    _textureUniform = glGetUniformLocation(_programHandle, "Texture");
    // Get the uniform model-view matrix slot from program
    //
    _modelViewSlot = glGetUniformLocation(_programHandle, "modelView");
    
    // Get the uniform projection matrix slot from program
    //
    _projectionSlot = glGetUniformLocation(_programHandle, "projection");

}

//////-shader


- (void)setupVBOs {
    
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
}
//setup a VAO
- (void)setupVAO{
    //gen and bind VAO as current object.
    glGenVertexArrays(1, &self->_objectA);
    glBindVertexArray(self->_objectA);
    
    // bind VBOs for current object
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    
    

    //使用glVertexAttribPointer来向顶点着色器的两个输入变量定位缓存的入口
    //参数：1将要设置的属性名，2每个顶点有几个值（维度），3数据类型，4数据是否标准化，5步长(下个属性数据组出现的位置)，6偏移量（距离缓冲起始位置）
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
    
    glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 7));
    
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);
    
    glEnableVertexAttribArray(_texCoordSlot);

    
    // 一般当你打算绘制多个物体时，你首先要生成/配置所有的VAO（和必须的VBO及属性指针)，然后储存它们供后面使用。当我们打算绘制物体的时候就拿出相应的VAO，绑定它，绘制完物体后，再解绑VAO。
    glBindVertexArray(0);//unbind to exit editing.
    
}


-(void)updateProjection
{
    // Generate a perspective matrix with a 60 degree FOV
    //
    ksMatrixLoadIdentity(&_projectionMatrix);
    
    //视角，长宽比，近平面距离，远平面距离
    ksPerspective(&_projectionMatrix, _sightAngleY, _aspect, _nearZ, _farZ);
    
    // Load projection matrix(传送数据)
    glUniformMatrix4fv(_projectionSlot, 1, GL_FALSE, (GLfloat*)&_projectionMatrix.m[0][0]);
}
- (void)updateTransform
{
    // Generate a model view matrix to rotate/translate/scale
    //
    ksMatrixLoadIdentity(&_modelViewMatrix);
    
    // Translate away from the viewer
    
    ksMatrixTranslate(&_modelViewMatrix, _posX, _posY, _posZ);
    
    // Rotate the triangle
    //
    ksMatrixRotate(&_modelViewMatrix, _angle, _rotateX, _rotateY, _rotateZ);
    
    // Scale
    
    ksMatrixScale(&_modelViewMatrix, scaleX, scaleY, scaleZ);
    
    // Load the model-view matrix(传送数据)
    glUniformMatrix4fv(_modelViewSlot, 1, GL_FALSE, (GLfloat*)&_modelViewMatrix.m[0][0]);
}

//- (void)render {  //绘制
//    glClearColor(0, 255, 0, 1);  //R,G,B,alpha
//    glClear(GL_COLOR_BUFFER_BIT);
//
//    [_context presentRenderbuffer:GL_RENDERBUFFER];
//}

- (void)render {  //render func for shader
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    //using same texture
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _myTexture);
    glUniform1i(_textureUniform, 0);
    
    //使用glViewport设置UIView的一部分来进行渲染
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    _posX = 5.0;
    _posY = 0.0;
    _posZ = -30.0;
    
    _rotateX = 1.0;
    _rotateY = 1.0;
    _rotateZ = 1.0;
    static GLfloat angleA = 0;
    angleA += 2;
    _angle = angleA;
    
    scaleX = 2;
    scaleY = 2;
    scaleZ = 2;
    
    [self updateProjection];
    [self updateTransform];
    

//    // 一般当你打算绘制多个物体时，你首先要生成/配置所有的VAO（和必须的VBO及属性指针)，然后储存它们供后面使用。当我们打算绘制物体的时候就拿出相应的VAO，绑定它，绘制完物体后，再解绑VAO。
    glBindVertexArray(_objectA);// bind objA

//    //调用glDrawElements。这最终会为传入的每个顶点调用顶点着色器，然后为将要显示的像素调用片段着色器。
//    //参数：1绘制顶点的方式（GL_TRIANGLES, GL_LINES, GL_POINTS, etc.）, 2需要渲染的顶点个数，3索引数组中每个索引的数据类型，4（使用了已经传入GL_ELEMENT_ARRAY_BUFFER的索引数组）指向索引的指针。
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    
    glBindVertexArray(0);//unbind
    //cube 2
    _posX = -5.0;
    _posY = 0.0;
    _posZ = -30.0;
    
    _rotateX = 1.0;
    _rotateY = -1.0;
    _rotateZ = 1.0;
    
    scaleX = 1;
    scaleY = 1;
    scaleZ = 2;
    
    static GLfloat angleB = 0;
    angleB += 0.3;
    _angle = angleB;
    [self updateProjection];
    [self updateTransform];
    
    glBindVertexArray(_objectA);// bind objA
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    glBindVertexArray(0);//unbind
    
    _posX = 0.0;
    _posY = 0.0;
    _posZ = -20.0;
    
    _rotateX = -1.0;
    _rotateY = 1.0;
    _rotateZ = 1.0;
    
    scaleX = 1;
    scaleY = 1;
    scaleZ = 1;

    static GLfloat angleC = 0;
    angleC += 2;
    _angle = angleC;
    [self updateProjection];
    [self updateTransform];
    
    glBindVertexArray(_objectA);// bind objA
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    glBindVertexArray(0);//unbind
    
    
    
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    static UInt64 lasttime;
    UInt64 timval = recordTime - lasttime;
    lasttime = recordTime;
    int fps = (1.0/timval)*1000;
    NSLog(@"timval:%llums; FPS:%d", timval,fps);
    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}


@end

