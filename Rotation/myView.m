//
//  paintFuncs.m
//  Rotation
//
//  Created by Fan Yang on 2018/6/4.
//  Copyright © 2018年 byteD. All rights reserved.
//
#import <OpenGLES/ES3/gl.h>  //glXXX etc.
#import <OpenGLES/ES3/glext.h>  //extensions

#import <UIKit/UIKit.h>
#import "myView.h"

#define TEX_COORD_MAX   1
#define GRD_TEX_COORD_MAX   5
#define GRASS_TEX_MAX   1

#define E_PI 3.1415926535897932384626433832795028841971693993751058209749445923078164062

ksVec3 cubePositions[] = {
    { 0.0f,  0.0f,  0.0f },
    { 2.0f,  5.0f, -15.0f},
    {-1.5f, -2.2f, -2.5f },
    {-3.8f, -2.0f, -12.3f},
    { 2.4f, -0.4f, -3.5f },
    {-1.7f,  3.0f, -7.5f },
    { 1.3f, -2.0f, -2.5f },
    { 1.5f,  2.0f, -2.5f },
    { 1.5f,  0.2f, -1.5f },
    {-1.3f,  1.0f, -1.5f }
};

ksVec3 pointLightPositions[] = {
    { 0.7f,  0.2f,  2.0f },
    { 2.3f, -3.3f, -4.0f },
    {-4.0f,  2.0f, -12.0f},
    { 0.0f,  0.0f, -3.0f }
};
/////cube
const Vertex Vertices[] = {
    // Front
    {{1, -1, 1}, {1, 0, 0, 1}, {0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, 1}, {1, 0, 0, 1}, {0, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, 1}, {1, 0, 0, 1}, {0, 0, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, 1}, {1, 0, 0, 1}, {0, 0, 1}, {0, 0}},
    // Back
    {{1, 1, -1}, {0, 1, 0, 1}, {0, 0, -1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -1}, {0, 1, 0, 1}, {0, 0, -1}, {TEX_COORD_MAX, 0}},
    {{1, -1, -1}, {0, 1, 0, 1}, {0, 0, -1}, {0, 0}},
    {{-1, 1, -1}, {0, 1, 0, 1}, {0, 0, -1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    // Left
    {{-1, -1, 1}, {0, 0, 1, 1}, {-1, 0, 0}, {TEX_COORD_MAX, 0}},
    {{-1, 1, 1}, {0, 0, 1, 1}, {-1, 0, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -1}, {0, 0, 1, 1}, {-1, 0, 0}, {0, TEX_COORD_MAX}},
    {{-1, -1, -1}, {0, 0, 1, 1}, {-1, 0, 0}, {0, 0}},
    // Right
    {{1, -1, -1}, {1, 1, 1, 1}, {1, 0, 0}, {TEX_COORD_MAX, 0}},
    {{1, 1, -1}, {1, 1, 1, 1}, {1, 0, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, 1, 1}, {1, 1, 1, 1}, {1, 0, 0}, {0, TEX_COORD_MAX}},
    {{1, -1, 1}, {1, 1, 1, 1}, {1, 0, 0}, {0, 0}},
    // Top
    {{1, 1, 1}, {1, 1, 0, 1}, {0, 1, 0}, {TEX_COORD_MAX, 0}},
    {{1, 1, -1}, {1, 1, 0, 1}, {0, 1, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -1}, {1, 1, 0, 1}, {0, 1, 0}, {0, TEX_COORD_MAX}},
    {{-1, 1, 1}, {1, 1, 0, 1}, {0, 1, 0}, {0, 0}},
    // Bottom
    {{1, -1, -1}, {0, 1, 1, 1}, {0, -1, 0}, {TEX_COORD_MAX, 0}},
    {{1, -1, 1}, {0, 1, 1, 1}, {0, -1, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, -1, 1}, {0, 1, 1, 1}, {0, -1, 0}, {0, TEX_COORD_MAX}},
    {{-1, -1, -1}, {0, 1, 1, 1}, {0, -1, 0}, {0, 0}}
};
//ground
const Vertex groundVert[] = {
    {{1, 0, 1}, {1, 1, 0, 1}, {0, 1, 0}, {GRD_TEX_COORD_MAX, 0}},
    {{1, 0, -1}, {1, 1, 0, 1}, {0, 1, 0}, {GRD_TEX_COORD_MAX, GRD_TEX_COORD_MAX}},
    {{-1, 0, -1}, {1, 1, 0, 1}, {0, 1, 0}, {0, GRD_TEX_COORD_MAX}},
    {{-1, 0, 1}, {1, 1, 0, 1}, {0, 1, 0}, {0, 0}},
    
};

const Vertex grassVert[] = {
    {{1, 1, 0}, {1, 1, 0, 1}, {0, 1, 0}, {GRASS_TEX_MAX, 0}},
    {{-1, 1, 0}, {1, 1, 0, 1}, {0, 1, 0}, {0, 0}},
    {{-1, -1, 0}, {1, 1, 0, 1}, {0, 1, 0}, {0, GRASS_TEX_MAX}},
    {{1, -1, 0}, {1, 1, 0, 1}, {0, 1, 0}, {GRASS_TEX_MAX, GRASS_TEX_MAX}},
    
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
//ground
const GLubyte groundIndices[] = {
    0, 1, 2,
    2, 3, 0,
};

const GLubyte grassIndices[] = {
    0, 1, 2,
    2, 3, 0,
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
    // 生成 renderbuffer ( renderbuffer->framebuffer-> 用于展示的窗口 )
    glGenRenderbuffers(1, &_colorrenderbuffer);
    // 绑定 renderbuffer
    glBindRenderbuffer(GL_RENDERBUFFER, _colorrenderbuffer);
    // GL_RENDERBUFFER 的内容存储到实现 EAGLDrawable 协议的 CAEAGLLayer
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

- (void)setupDepthStencilBuffer {
    glGenRenderbuffers(1, &_depthStencilRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthStencilRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8, self.frame.size.width, self.frame.size.height);
//use one buffer to restore depth and stencil data
}


- (void)setupFrameBuffer {
    glGenFramebuffers(1, &_framebuffer);
    // 设置为当前 framebuffer
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    [self setupRenderBuffer];
    [self setupDepthStencilBuffer];

    // 将 _colorRenderBuffer 装配到 GL_COLOR_ATTACHMENT0 这个装配点上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,GL_RENDERBUFFER, _colorrenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthStencilRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_STENCIL_ATTACHMENT, GL_RENDERBUFFER, _depthStencilRenderBuffer);

    //check frame buffer
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if(status != GL_FRAMEBUFFER_COMPLETE)
        NSLog(@"frame buffer assembling ERROR: %x \n", status);
    glBindFramebuffer(GL_FRAMEBUFFER, 0);  //unbind frame buffer
    
//    //////////////////////////////////////////////////fbo for texture rendering
    glGenFramebuffers(1, &_textureFrameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _textureFrameBuffer);

    // The texture we're going to render to, 创建一个纹理图像，我们将它作为一个颜色附件附加到帧缓冲上
    GLuint renderedTexture;
    glGenTextures(1, &renderedTexture);
    // "Bind" the newly created texture : all future texture functions will modify this texture
    glBindTexture(GL_TEXTURE_2D, renderedTexture);

    // Give an empty image to OpenGL ( the last "0" )
    glTexImage2D(GL_TEXTURE_2D, 0,GL_RGBA, self.frame.size.width, self.frame.size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, 0);

    // Poor filtering. Needed !最近取样（方块风格
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

//     //Set "renderedTexture" as our colour attachement #0
//    glFramebufferTexture(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, renderedTexture, 0);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, renderedTexture, 0);
//
    //////     render buffer for texture fbo
    GLuint rbo;
    glGenRenderbuffers(1, &rbo);
    glBindRenderbuffer(GL_RENDERBUFFER, rbo);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8, self.frame.size.width, self.frame.size.height);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_STENCIL_ATTACHMENT, GL_RENDERBUFFER, rbo);
    

    status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if(status != GL_FRAMEBUFFER_COMPLETE)
        NSLog(@"texture frame buffer assembling ERROR: %x \n", status);
    glBindFramebuffer(GL_FRAMEBUFFER, 0);  //unbind texture frame buffer
////////////////////////////////////////////////////////////
}
- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &_framebuffer);
    _framebuffer = 0;
    glDeleteRenderbuffers(1, &_colorrenderbuffer);
    _colorrenderbuffer = 0;
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
    // compile lamp shader program
    GLuint lampvertexShader = [self compileShader:@"lampVertex"
                                     withType:GL_VERTEX_SHADER];
    GLuint lampfragmentShader = [self compileShader:@"lampFragment"
                                       withType:GL_FRAGMENT_SHADER];
    
    // 调用接下来的func来创建和将shader们连接到program。当链接着色器至一个程序的时候，它会把每个着色器的输出链接到下个着色器的输入。当输出和输入不匹配的时候，会得到一个链接错误
    _programHandle = glCreateProgram();
    glAttachShader(_programHandle, vertexShader);
    glAttachShader(_programHandle, fragmentShader);
    glLinkProgram(_programHandle);
    //link lamp program
    _lampProgram = glCreateProgram();
    glAttachShader(_lampProgram, lampvertexShader);
    glAttachShader(_lampProgram, lampfragmentShader);
    glLinkProgram(_lampProgram);
    
    // check
    GLint linkSuccess;
    glGetProgramiv(_programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"lighting program fail: %@", messageString);
        exit(1);
    }
    GLint lampLinkSuccess;
    glGetProgramiv(_lampProgram, GL_LINK_STATUS, &lampLinkSuccess);
    if (lampLinkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(_lampProgram, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"lamp program fail: %@", messageString);
        exit(1);
    }
    
    // 调用glGetAttribLocatuon来获取顶点着色器输入的入口，以便加入代码。同时调用glEnableVertexAttribArray方法，以顶点属性值作为参数，启用顶点属性（顶点属性默认是禁用的）。
    _positionSlot = glGetAttribLocation(_programHandle, "Position");
    _colorSlot = glGetAttribLocation(_programHandle, "SourceColor");
    _normalSlot = glGetAttribLocation(_programHandle, "normal");
    
    ////lamp attribs
    _lampPositionSlot = glGetAttribLocation(_lampProgram, "Position");
    _lampTexCoordSlot = glGetAttribLocation(_lampProgram, "TexCoordIn");
    
    //texture
    _texCoordSlot = glGetAttribLocation(_programHandle, "TexCoordIn");
    _textureUniform = glGetUniformLocation(_programHandle, "Texture");
    
    // Get the uniform model-view matrix slot from program
    _modelSlot = glGetUniformLocation(_programHandle, "model");
    // Get the uniform projection matrix slot from program
    _projectionSlot = glGetUniformLocation(_programHandle, "projection");
    // Get the uniform view matrix slot from program
    _lookViewSlot = glGetUniformLocation(_programHandle, "lookView");
    ///////////////////////////mvp mat slot setup for lamp
    _lampModelSlot = glGetUniformLocation(_lampProgram, "model");
    _lampProjectionSlot = glGetUniformLocation(_lampProgram, "projection");
    _lampLookViewSlot = glGetUniformLocation(_lampProgram, "lookView");
    _lampTextureUniform = glGetUniformLocation(_lampProgram, "grassTex");

    ////////////////////////////////
    _eyePosSlot = glGetUniformLocation(_programHandle, "eyePos");
    
    _diffuseMapSlot = glGetUniformLocation(_programHandle, "material.diffuse");
    _specularMapSlot = glGetUniformLocation(_programHandle, "material.specular");
    _shininessSlot = glGetUniformLocation(_programHandle, "material.shininess");
   //light slot init
    _spotLightPositionSlot = glGetUniformLocation(_programHandle, "spotLight.position");
    _spotLightDircSlot = glGetUniformLocation(_programHandle, "spotLight.direction");
    _spotLightAmbientSlot = glGetUniformLocation(_programHandle, "spotLight.ambient");
    _spotLightDiffuseSlot = glGetUniformLocation(_programHandle, "spotLight.diffuse");
    _spotLightSpecularSlot = glGetUniformLocation(_programHandle, "spotLight.specular");
    _spotLightConstantSlot = glGetUniformLocation(_programHandle, "spotLight.constant");
    _spotLightLinearSlot = glGetUniformLocation(_programHandle, "spotLight.linear");
    _spotLightQuadraticSlot = glGetUniformLocation(_programHandle, "spotLight.quadratic");
    _spotLightCutOffSlot = glGetUniformLocation(_programHandle, "spotLight.cutOff");
    _spotLightOuterCutOffSlot = glGetUniformLocation(_programHandle, "spotLight.outerCutOff");
    //directional light slots init
    _dirLightDircSlot = glGetUniformLocation(_programHandle, "dirLight.direction");
    _dirLightAmbntSlot = glGetUniformLocation(_programHandle, "dirLight.ambient");
    _dirLightDifsSlot = glGetUniformLocation(_programHandle, "dirLight.diffuse");
    _dirLightSpclSlot = glGetUniformLocation(_programHandle, "dirLight.specular");
    //point light slots init
    _pointLightPosSlot0 = glGetUniformLocation(_programHandle, "pointLights[0].position");
    _pointLightAmbntSlot0 = glGetUniformLocation(_programHandle, "pointLights[0].ambient");
    _pointLightDifsSlot0 = glGetUniformLocation(_programHandle, "pointLights[0].diffuse");
    _pointLightSpclSlot0 = glGetUniformLocation(_programHandle, "pointLights[0].specular");
    _pointLightConstSlot0 = glGetUniformLocation(_programHandle, "pointLights[0].constant");
    _pointLightLinearSlot0 = glGetUniformLocation(_programHandle, "pointLights[0].linear");
    _pointLightQuadSlot0 = glGetUniformLocation(_programHandle, "pointLights[0].quadratic");
    
    _pointLightPosSlot1 = glGetUniformLocation(_programHandle, "pointLights[1].position");
    _pointLightAmbntSlot1 = glGetUniformLocation(_programHandle, "pointLights[1].ambient");
    _pointLightDifsSlot1 = glGetUniformLocation(_programHandle, "pointLights[1].diffuse");
    _pointLightSpclSlot1 = glGetUniformLocation(_programHandle, "pointLights[1].specular");
    _pointLightConstSlot1 = glGetUniformLocation(_programHandle, "pointLights[1].constant");
    _pointLightLinearSlot1 = glGetUniformLocation(_programHandle, "pointLights[1].linear");
    _pointLightQuadSlot1 = glGetUniformLocation(_programHandle, "pointLights[1].quadratic");
    
    _pointLightPosSlot2 = glGetUniformLocation(_programHandle, "pointLights[2].position");
    _pointLightAmbntSlot2 = glGetUniformLocation(_programHandle, "pointLights[2].ambient");
    _pointLightDifsSlot2 = glGetUniformLocation(_programHandle, "pointLights[2].diffuse");
    _pointLightSpclSlot2 = glGetUniformLocation(_programHandle, "pointLights[2].specular");
    _pointLightConstSlot2 = glGetUniformLocation(_programHandle, "pointLights[2].constant");
    _pointLightLinearSlot2 = glGetUniformLocation(_programHandle, "pointLights[2].linear");
    _pointLightQuadSlot2 = glGetUniformLocation(_programHandle, "pointLights[2].quadratic");
    
    _pointLightPosSlot3 = glGetUniformLocation(_programHandle, "pointLights[3].position");
    _pointLightAmbntSlot3 = glGetUniformLocation(_programHandle, "pointLights[3].ambient");
    _pointLightDifsSlot3 = glGetUniformLocation(_programHandle, "pointLights[3].diffuse");
    _pointLightSpclSlot3 = glGetUniformLocation(_programHandle, "pointLights[3].specular");
    _pointLightConstSlot3 = glGetUniformLocation(_programHandle, "pointLights[3].constant");
    _pointLightLinearSlot3 = glGetUniformLocation(_programHandle, "pointLights[3].linear");
    _pointLightQuadSlot3 = glGetUniformLocation(_programHandle, "pointLights[3].quadratic");
    
    
}

//////-shader

- (void)setupProjection{
    _aspect = self.frame.size.width / self.frame.size.height;
    _sightAngleY = 60; //view y angle in degrees
    _nearZ = 1.0f;
    _farZ = 1000.0f;
}

//init transform matrix
- (void)setupTransform{
    modelPos.x = 0.0;
    modelPos.y = 0.0;
    modelPos.z = 0.0;
    
    modelRotate.x = 0.0;
    modelRotate.y = 0.0;
    modelRotate.z = 0.0;
    _angle = 0.0;
    
    modelScale.x = 1.0;
    modelScale.y = 1.0;
    modelScale.z = 1.0;
}
- (void)setupLookView{
    viewEye.x = 0;
    viewEye.y = 0;
    viewEye.z = 0;
    
    viewTgt.x = 0;
    viewTgt.y = 0;
    viewTgt.z = -1;
}
- (void)setupLight{

    material._difsLightingMap = _myTexture;
    material._spclLightingMap = _myTexture;
    material.shininess = 32.0; //init material

    dirLight.direction.x = -0.2;
    dirLight.direction.y = -1.0;
    dirLight.direction.z = -0.3;
    dirLight.ambient.x = 0.1;
    dirLight.ambient.y = 0.1;
    dirLight.ambient.z = 0.1;
    dirLight.diffuse.x = 0.3;
    dirLight.diffuse.y = 0.3;
    dirLight.diffuse.z = 0.3;
    dirLight.specular.x = 0.7;
    dirLight.specular.y = 0.7;
    dirLight.specular.z = 0.7;
    
    //paras for all point lights (except for pos)
    pointLight.ambient.x = 0.05f;
    pointLight.ambient.y = 0.05f;
    pointLight.ambient.z = 0.05f;
    pointLight.diffuse.x = 0.5f;
    pointLight.diffuse.y = 0.5f;
    pointLight.diffuse.z = 0.5f;
    pointLight.specular.x = 0.8f;
    pointLight.specular.y = 0.8f;
    pointLight.specular.z = 0.8f;
    pointLight.constant = 1.0f;
    pointLight.linear = 0.09;
    pointLight.quadratic = 0.032;
    
    spotLight.position.x = 0.0;
    spotLight.position.y = 0.0;
    spotLight.position.z = 0.0;
    spotLight.direction.x = 0.0;
    spotLight.direction.y = 0.0;
    spotLight.direction.z = -1.0;
    
    spotLight.constant = 1.0f;
    spotLight.linear = 0.09f;
    spotLight.quadratic = 0.032f;
    
    spotLight.cutOff = cosf(10.0 / 180.0 * E_PI);
    spotLight.outerCutOff = cosf(12.0 / 180.0 * E_PI);
    
    spotLight.ambient.x = 0.2;
    spotLight.ambient.y = 0.2;
    spotLight.ambient.z = 0.2;
    spotLight.diffuse.x = 0.5;
    spotLight.diffuse.y = 0.5;
    spotLight.diffuse.z = 0.5;
    spotLight.specular.x = 1.0;
    spotLight.specular.y = 1.0;
    spotLight.specular.z = 1.0;

}
- (GLuint)setupTexture:(NSString *)fileName {
    // 1) Get Core Graphics image reference.
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
    // 2) Create Core Graphics bitmap context. 自行分配空间。获取宽高，分配w*h*4字节的空间。（*4: r,g,b,alpha一共四个字节）
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    // 3) Draw the image into the context. 在指定矩形中绘制image，画完之后可以释放context.（存储在data中）
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);
    
    // 4) Send the pixel data to OpenGL. gen并bind textureObj。
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (int)width, (int)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    glGenerateMipmap(GL_TEXTURE_2D);
    
    free(spriteData);
    glBindTexture(GL_TEXTURE_2D, 0);

    return texName;
}
- (void) setupMaterial: (Material*) material withDfsTexture: (GLuint) texture1 spcTexture: (GLuint) texture2 Shininess: (float) shininess{
    material->_difsLightingMap = texture1;
    material->_spclLightingMap = texture2;
    material->shininess = shininess;
}


- (void)setupVBOs {
    
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &groundVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, groundVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(groundVert), groundVert, GL_STATIC_DRAW);
    
    glGenBuffers(1, &groundIndexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, groundIndexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(groundIndices), groundIndices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &grassVertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, grassVertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(grassVert), grassVert, GL_STATIC_DRAW);
    
    glGenBuffers(1, &grassIndexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, grassIndexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(grassIndices), grassIndices, GL_STATIC_DRAW);
    
}
//setup a VAO
- (void)setupVAO{
    //gen and bind VAO as current object.
    glGenVertexArrays(1, &_objectA);
    glBindVertexArray(_objectA);
    
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
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 10));
    glVertexAttribPointer(_normalSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*)(sizeof(float)*7));
    
    
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);
    
    glEnableVertexAttribArray(_texCoordSlot);
    glEnableVertexAttribArray(_normalSlot);

    
    // 一般当你打算绘制多个物体时，你首先要生成/配置所有的VAO（和必须的VBO及属性指针)，然后储存它们供后面使用。当我们打算绘制物体的时候就拿出相应的VAO，绑定它，绘制完物体后，再解绑VAO。
    glBindVertexArray(0);//unbind to exit editing.
    
    //ground
    glGenVertexArrays(1, &_groundObj);
    glBindVertexArray(_groundObj);
    
    glBindBuffer(GL_ARRAY_BUFFER, groundVertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, groundIndexBuffer);
    
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
    glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 10));
    glVertexAttribPointer(_normalSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*)(sizeof(float)*7));
    
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);
    glEnableVertexAttribArray(_texCoordSlot);
    glEnableVertexAttribArray(_normalSlot);
    
    glBindVertexArray(0);
    
    ///lamp

    glGenVertexArrays(1, &_lampObj);
    glBindVertexArray(_lampObj);
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    
    glVertexAttribPointer(_lampPositionSlot, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);

    glEnableVertexAttribArray(_lampPositionSlot);

    glBindVertexArray(0);
    
    //grass use modified lampProgram
    glGenVertexArrays(1, &_grassObj);
    glBindVertexArray(_grassObj);
    
    glBindBuffer(GL_ARRAY_BUFFER, grassVertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, grassIndexBuffer);
    
    glVertexAttribPointer(_lampPositionSlot, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    glVertexAttribPointer(_lampTexCoordSlot, 2, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 10));
    
    glEnableVertexAttribArray(_lampPositionSlot);
    glEnableVertexAttribArray(_lampTexCoordSlot);
    
    glBindVertexArray(0);
}

- (void)setup {
    [self setupLayer];
    [self setupContext];
    
    [self destoryRenderAndFrameBuffer];
    
//    [self setupDepthStencilBuffer];
//    [self setupRenderBuffer];
    
    [self setupFrameBuffer];

    [self compileShaders];
    
    [self setupVBOs];   //setup VBOs and push data, then bind them to VAOs
    [self setupVAO];
    
    [self setupProjection];
    [self setupTransform];
    [self setupLookView];
    [self setupLight];
    
    _myTexture = [self setupTexture:@"metal.png"];
    _groundTexture = [self setupTexture:@"ground.png"];
    _woodTexture = [self setupTexture:@"wood.png"];
    _frameTexture = [self setupTexture:@"frame.png"];
    _grassTexture = [self setupTexture:@"grass.png"];
    _windowTexture = [self setupTexture:@"window.png"];
    
    glActiveTexture(GL_TEXTURE1); //激活纹理单元
    glBindTexture(GL_TEXTURE_2D, _myTexture);
    glActiveTexture(GL_TEXTURE2);
    glBindTexture(GL_TEXTURE_2D, _groundTexture);
    glActiveTexture(GL_TEXTURE3);
    glBindTexture(GL_TEXTURE_2D, _woodTexture);
    glActiveTexture(GL_TEXTURE4);
    glBindTexture(GL_TEXTURE_2D, _frameTexture);
    glActiveTexture(GL_TEXTURE5);
    glBindTexture(GL_TEXTURE_2D, _grassTexture);
    glActiveTexture(GL_TEXTURE6);
    glBindTexture(GL_TEXTURE_2D, _windowTexture);
    
    
    [self setupMaterial:&metal withDfsTexture:1 spcTexture:1 Shininess:256.0];
    [self setupMaterial:&ground withDfsTexture:2 spcTexture:2 Shininess:8.0];
    [self setupMaterial:&wood withDfsTexture:3 spcTexture:4 Shininess:256.0];
    
}

///////////////////////////////////////////


-(void)updateProjection
{
    // Generate a perspective matrix with a 60 degree FOV
    //
    ksMatrixLoadIdentity(&_projectionMatrix);
    
    //视角，长宽比，近平面距离，远平面距离
//    ksOrtho(&_projectionMatrix, -5 * _aspect, 5 * _aspect, -5, 5, 1.0, 50.0);
    ksPerspective(&_projectionMatrix, _sightAngleY, _aspect, _nearZ, _farZ);
    
    // Load projection matrix(传送数据)
    glUniformMatrix4fv(_projectionSlot, 1, GL_FALSE, (GLfloat*)&_projectionMatrix.m[0][0]);
}
- (void)updateLampProjection{
    //lamp use same projection mat
    glUniformMatrix4fv(_lampProjectionSlot, 1, GL_FALSE, (GLfloat*)&_projectionMatrix.m[0][0]);
}
- (void)updateTransform
{
    // Generate a model view matrix to rotate/translate/scale
    //
    ksMatrixLoadIdentity(&_modelMatrix);
    // Scale
    ksMatrixScale(&_modelMatrix, modelScale.x, modelScale.y, modelScale.z);
    // Rotate the triangle
    //
    ksMatrixRotate(&_modelMatrix, _angle, modelRotate.x, modelRotate.y, modelRotate.z);
    // Translate away from the viewer
    ksMatrixTranslate(&_modelMatrix, modelPos.x, modelPos.y, modelPos.z);
    // Load the model-view matrix(传送数据)
    glUniformMatrix4fv(_modelSlot, 1, GL_FALSE, (GLfloat*)&_modelMatrix.m[0][0]);
}
- (void)updateLampTransform{
    ksMatrixLoadIdentity(&_lampModelMatrix);
    ksMatrixScale(&_lampModelMatrix, modelScale.x, modelScale.y, modelScale.z);
    ksMatrixTranslate(&_lampModelMatrix, modelPos.x, modelPos.y, modelPos.z);
    ksMatrixRotate(&_lampModelMatrix, _angle, modelRotate.x, modelRotate.y, modelRotate.z);
    glUniformMatrix4fv(_lampModelSlot, 1, GL_FALSE, (GLfloat*)&_lampModelMatrix.m[0][0]);
}
- (void)updateView{
    // Generate a view matrix
    //
    ksMatrixLoadIdentity(&_lookViewMatrix);
//    ksVec3 eye;
//    eye.x = viewEye.x;
//    eye.y = viewEye.y;
//    eye.z = viewEye.z;
//    ksVec3 target;
//    target.x = viewTgt.x;
//    target.y = viewTgt.y;
//    target.z = viewTgt.z;
    ksVec3 up;
    up.x = 0;
    up.y = 1;
    up.z = 0;
    //视角，长宽比，近平面距离，远平面距离
    ksLookAt(&_lookViewMatrix, &viewEye, &viewTgt, &up);
    // Load projection matrix(传送数据)
    glUniformMatrix4fv(_lookViewSlot, 1, GL_FALSE, (GLfloat*)&_lookViewMatrix.m[0][0]);
    //load eye position uniform
    glUniform3f(_eyePosSlot, viewEye.x, viewEye.y, viewEye.z);
}
- (void)updateLampView{
    glUniformMatrix4fv(_lampLookViewSlot, 1, GL_FALSE, (GLfloat*)&_lookViewMatrix.m[0][0]);
}
- (void) updateLight{
    //update directional light para
    glUniform3f(_dirLightDircSlot, dirLight.direction.x, dirLight.direction.y, dirLight.direction.z);
    glUniform3f(_dirLightAmbntSlot, dirLight.ambient.x, dirLight.ambient.y, dirLight.ambient.z);
    glUniform3f(_dirLightDifsSlot, dirLight.diffuse.x, dirLight.diffuse.y, dirLight.diffuse.z);
    glUniform3f(_dirLightSpclSlot, dirLight.specular.x, dirLight.specular.y, dirLight.specular.z);
    //update point light paras
    glUniform3f(_pointLightPosSlot0, pointLightPositions[0].x, pointLightPositions[0].y, pointLightPositions[0].z);
    glUniform3f(_pointLightAmbntSlot0, pointLight.ambient.x, pointLight.ambient.y, pointLight.ambient.z);
    glUniform3f(_pointLightDifsSlot0, pointLight.diffuse.x, pointLight.diffuse.y, pointLight.diffuse.z);
    glUniform3f(_pointLightSpclSlot0, pointLight.specular.x, pointLight.specular.y, pointLight.specular.z);
    glUniform1f(_pointLightConstSlot0, pointLight.constant);
    glUniform1f(_pointLightLinearSlot0, pointLight.linear);
    glUniform1f(_pointLightQuadSlot0, pointLight.quadratic);
    
    glUniform3f(_pointLightPosSlot1, pointLightPositions[1].x, pointLightPositions[1].y, pointLightPositions[1].z);
    glUniform3f(_pointLightAmbntSlot1, pointLight.ambient.x, pointLight.ambient.y, pointLight.ambient.z);
    glUniform3f(_pointLightDifsSlot1, pointLight.diffuse.x, pointLight.diffuse.y, pointLight.diffuse.z);
    glUniform3f(_pointLightSpclSlot1, pointLight.specular.x, pointLight.specular.y, pointLight.specular.z);
    glUniform1f(_pointLightConstSlot1, pointLight.constant);
    glUniform1f(_pointLightLinearSlot1, pointLight.linear);
    glUniform1f(_pointLightQuadSlot1, pointLight.quadratic);
    
    glUniform3f(_pointLightPosSlot2, pointLightPositions[2].x, pointLightPositions[2].y, pointLightPositions[2].z);
    glUniform3f(_pointLightAmbntSlot2, pointLight.ambient.x, pointLight.ambient.y, pointLight.ambient.z);
    glUniform3f(_pointLightDifsSlot2, pointLight.diffuse.x, pointLight.diffuse.y, pointLight.diffuse.z);
    glUniform3f(_pointLightSpclSlot2, pointLight.specular.x, pointLight.specular.y, pointLight.specular.z);
    glUniform1f(_pointLightConstSlot2, pointLight.constant);
    glUniform1f(_pointLightLinearSlot2, pointLight.linear);
    glUniform1f(_pointLightQuadSlot2, pointLight.quadratic);
    
    glUniform3f(_pointLightPosSlot3, pointLightPositions[3].x, pointLightPositions[3].y, pointLightPositions[3].z);
    glUniform3f(_pointLightAmbntSlot3, pointLight.ambient.x, pointLight.ambient.y, pointLight.ambient.z);
    glUniform3f(_pointLightDifsSlot3, pointLight.diffuse.x, pointLight.diffuse.y, pointLight.diffuse.z);
    glUniform3f(_pointLightSpclSlot3, pointLight.specular.x, pointLight.specular.y, pointLight.specular.z);
    glUniform1f(_pointLightConstSlot3, pointLight.constant);
    glUniform1f(_pointLightLinearSlot3, pointLight.linear);
    glUniform1f(_pointLightQuadSlot3, pointLight.quadratic);
    
    //    update spot light para
    glUniform3f(_spotLightPositionSlot, spotLight.position.x, spotLight.position.y, spotLight.position.z);
    glUniform3f(_spotLightDircSlot, spotLight.direction.x, spotLight.direction.y, spotLight.direction.z);
    glUniform3f(_spotLightAmbientSlot, spotLight.ambient.x, spotLight.ambient.y, spotLight.ambient.z);
    glUniform3f(_spotLightDiffuseSlot, spotLight.diffuse.x, spotLight.diffuse.y, spotLight.diffuse.z);
    glUniform3f(_spotLightSpecularSlot, spotLight.specular.x, spotLight.specular.y, spotLight.specular.z);
    glUniform1f(_spotLightConstantSlot, spotLight.constant);
    glUniform1f(_spotLightLinearSlot, spotLight.linear);
    glUniform1f(_spotLightQuadraticSlot, spotLight.quadratic);
    glUniform1f(_spotLightCutOffSlot, spotLight.cutOff);
    glUniform1f(_spotLightOuterCutOffSlot, spotLight.outerCutOff);
}

- (void) updateMaterial{
    //update material para
    glUniform1i(_diffuseMapSlot, material._difsLightingMap);
    glUniform1i(_specularMapSlot, material._spclLightingMap);
    glUniform1f(_shininessSlot, material.shininess);
}

///////////////////////////////////////////////////////////

- (void)inintScene{
    
//    glEnable(GL_STENCIL_TEST);//开启模版测试
    glEnable(GL_DEPTH_TEST);//开启深度测试
//    glDepthFunc(GL_NOTEQUAL);  //默认是less
    
//    glEnable(GL_BLEND);
//    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    //set viewport
    //使用glViewport设置UIView的一部分来进行渲染
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
    //setup lighting program first
    glUseProgram(_programHandle);
    //static light spot
    //set light source position
    spotLight.position.x = 0.0f;
    spotLight.position.y = 0.0f;
    spotLight.position.z = 0.0f;
    
    spotLight.direction.x = 0.0f;
    spotLight.direction.y = 0.0f;
    spotLight.direction.z = -1.0f;
    
    //set Attenuation(衰减)
    spotLight.constant = 1.0f;
    spotLight.linear = 0.09f;
    spotLight.quadratic = 0.032f;
    //light color
    ksVec3 lightColor = {1.0, 1.0, 1.0};
    ksVec3 abntIndex = {0.1, 0.1, 0.1};
    ksVec3 difsIndex = {0.9, 0.9, 0.9};
    
    lightColor.x = 1.0;
    lightColor.y = 1.0;
    lightColor.z = 1.0;
    //varing light color
    //    static float colorAngle = 0;
    //    lightColor.x = sinf(colorAngle * 2.0);
    //    lightColor.y = sinf(colorAngle * 0.7);
    //    lightColor.z = sinf(colorAngle * 1.3);
    //    colorAngle += 0.01;
    fyVectorGLSLProduct(&spotLight.ambient, &lightColor, &abntIndex);
    fyVectorGLSLProduct(&spotLight.diffuse, &lightColor, &difsIndex);
    
    spotLight.cutOff = cosf(20.0 / 180.0 * E_PI);
    spotLight.outerCutOff = cosf(25.0 / 180.0 * E_PI);
    [self updateLight]; //static light
    
    //look at the same spot
    viewTgt.x = 0;
    viewTgt.y = 0;
    viewTgt.z = 0;
    [self updateView];
    [self updateProjection];// 更新投影矩阵

    //then setup lamp program
    glUseProgram(_lampProgram);
    [self updateLampProjection];
    [self updateLampView];
}

//////////////////////////////////////////////////////////////////////////////////////////

- (void)render {  //render func for shader
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    
    glClearColor(0.07, 0.07, 0.07, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);//stencil bit all set to 0x1

    // 得到着色器程序对象后，我们可以调用 glUseProgram 函数，用刚创建的程序对象作为它的参数，以激活这个程序对象。
    // 告诉OpenGL在获得顶点信息后，调用刚才的程序来处理
    //use lighting program to render cubes
    glUseProgram(_programHandle);
 
    //set view parameters
    static float viewRotateAngle = 0.33 * E_PI;
    float viewRotateRad = 5.0;
    viewEye.x = viewRotateRad*cosf(viewRotateAngle);
//    viewEye.x = 2.0f;

    viewEye.y = 1.6;
    viewEye.z = viewRotateRad*sinf(viewRotateAngle);
//    viewEye.z = 2.0f;

    viewRotateAngle += 0.01;
    
    [self updateView];

    spotLight.position = viewEye; //light from eye
    spotLight.direction.x = viewTgt.x - viewEye.x; //light point at tgt
    spotLight.direction.y = viewTgt.y - viewEye.y;
    spotLight.direction.z = viewTgt.z - viewEye.z;
    glUniform3f(_spotLightPositionSlot, spotLight.position.x, spotLight.position.y, spotLight.position.z); //update uinform
    glUniform3f(_spotLightDircSlot, spotLight.direction.x, spotLight.direction.y, spotLight.direction.z);
    
//    /////////////////////////////ground
//    glBindVertexArray(_groundObj);
//    material = ground;
//    [self updateMaterial];
//    modelPos.y = -1;
//    modelScale.x = 10.0f;
//    modelScale.y = 10.0f;
//    modelScale.z = 10.0f;
//    [self updateTransform];
//    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
//    glBindVertexArray(0);
//
    ///////////////////////////////
    // 一般当你打算绘制多个物体时，你首先要生成/配置所有的VAO（和必须的VBO及属性指针)，然后储存它们供后面使用。当我们打算绘制物体的时候就拿出相应的VAO，绑定它，绘制完物体后，再解绑VAO。
    glBindVertexArray(_objectA);
    //applying  texture
    //    glActiveTexture(GL_TEXTURE0);
    //    glBindTexture(GL_TEXTURE_2D, _myTexture);
    //    glUniform1i(_textureUniform, 0);
    material = wood;
    [self updateMaterial]; //all cubes using same material
    for(unsigned int i = 0; i < 10; i++)
    {
        modelPos = cubePositions[i];
        
        modelRotate.x = 1.0f;
        modelRotate.y = 0.3f;
        modelRotate.z = 0.5f;
        float angle = 20.0f * i;
        _angle = angle;
        modelScale.x = 0.5f;
        modelScale.y = 0.5f;
        modelScale.z = 0.5f;
        [self updateTransform];
        //调用glDrawElements。这最终会为传入的每个顶点调用顶点着色器，然后为将要显示的像素调用片段着色器。
        //参数：1绘制顶点的方式（GL_TRIANGLES, GL_LINES, GL_POINTS, etc.）, 2需要渲染的顶点个数，3索引数组中每个索引的数据类型，4（使用了已经传入GL_ELEMENT_ARRAY_BUFFER的索引数组）指向索引的指针。
        glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    }
    glBindVertexArray(0);//unbind vao

    //then use lamp program to render lamps
    glUseProgram(_lampProgram);
    glBindVertexArray(_lampObj);
    [self updateLampView];
    for(unsigned int j = 0; j < 4; j++){
        modelPos = pointLightPositions[j];
        _angle = 0;
        modelScale.x = 0.1;
        modelScale.y = 0.1;
        modelScale.z = 0.1;
        modelRotate.x = 0.0;
        modelRotate.y = 1.0;
        modelRotate.z = 0.0;
        [self updateLampTransform];
        glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    }
    glBindVertexArray(0);//unbind vao
    
    //count fps
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    static UInt64 lasttime;
    UInt64 timval = recordTime - lasttime;
    lasttime = recordTime;
    int fps = (1.0/timval)*1000;
    NSLog(@"timval:%llums; FPS:%d", timval,fps);
    
    glBindRenderbuffer(GL_RENDERBUFFER, _colorrenderbuffer);
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}


@end


