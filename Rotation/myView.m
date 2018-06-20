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

//typedef struct {  //光照材质
    //ksVec3 ambient;
    //ksVec3 diffuse;
    //ksVec3 specular;
    //float shininess;
//} Material;
//const Material metalMaterial = {{1.0, 1.0, 1.0}, {1.0, 1.0, 1.0}, {1.0, 1.0, 1.0}, 256.0};
//const Material groundMaterial = {{1.0, 1.0, 1.0},{1.0, 1.0, 1.0}, {0.1, 0.1, 0.1}, 0};
//const Material woodMaterial = {{0.5, 0.25, 0.1}, {0.5, 0.25, 0.1}, {1.0, 1.0, 1.0}, 16};


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
    _normalSlot = glGetAttribLocation(_programHandle, "normal");
    
    //texture
    _texCoordSlot = glGetAttribLocation(_programHandle, "TexCoordIn");
    _textureUniform = glGetUniformLocation(_programHandle, "Texture");
    
    // Get the uniform model-view matrix slot from program
    _modelSlot = glGetUniformLocation(_programHandle, "model");
    // Get the uniform projection matrix slot from program
    _projectionSlot = glGetUniformLocation(_programHandle, "projection");
    // Get the uniform view matrix slot from program
    _lookViewSlot = glGetUniformLocation(_programHandle, "lookView");
    
//    _lightDrcSlot = glGetUniformLocation(_programHandle, "lightDirection");
    _eyePosSlot = glGetUniformLocation(_programHandle, "eyePos");
    
    _diffuseMapSlot = glGetUniformLocation(_programHandle, "material.diffuse");
    _specularMapSlot = glGetUniformLocation(_programHandle, "material.specular");
    _shininessSlot = glGetUniformLocation(_programHandle, "material.shininess");
    
    _lightPositionSlot = glGetUniformLocation(_programHandle, "light.position");
    _lightDircSlot = glGetUniformLocation(_programHandle, "light.direction");
    _lightAmbientSlot = glGetUniformLocation(_programHandle, "light.ambient");
    _lightDiffuseSlot = glGetUniformLocation(_programHandle, "light.diffuse");
    _lightSpecularSlot = glGetUniformLocation(_programHandle, "light.specular");
    _lightConstantSlot = glGetUniformLocation(_programHandle, "light.constant");
    _lightLinearSlot = glGetUniformLocation(_programHandle, "light.linear");
    _lightQuadraticSlot = glGetUniformLocation(_programHandle, "light.quadratic");
    _lightCutOffSlot = glGetUniformLocation(_programHandle, "light.cutOff");
    _lightOuterCutOffSlot = glGetUniformLocation(_programHandle, "light.outerCutOff");
    
    
    
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
    
    modleRotate.x = 0.0;
    modleRotate.y = 0.0;
    modleRotate.z = 0.0;
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
    light.position.x = 0.0;
    light.position.y = 0.0;
    light.position.z = 0.0;
    light.direction.x = 0.0;
    light.direction.y = 0.0;
    light.direction.z = -1.0;
    
    light.constant = 1.0f;
    light.linear = 0.09f;
    light.quadratic = 0.032f;
    
    light.cutOff = cosf(10.0 / 180.0 * E_PI);
    light.outerCutOff = cosf(12.0 / 180.0 * E_PI);
    

    material._difsLightingMap = _myTexture;
    material._spclLightingMap = _myTexture;
    material.shininess = 32.0; //init material
    
    light.ambient.x = 0.2;
    light.ambient.y = 0.2;
    light.ambient.z = 0.2;
    light.diffuse.x = 0.5;
    light.diffuse.y = 0.5;
    light.diffuse.z = 0.5;
    light.specular.x = 1.0;
    light.specular.y = 1.0;
    light.specular.z = 1.0;
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
    [self setupLookView];
    [self setupLight];
    
    _myTexture = [self setupTexture:@"metal.png"];
    _groundTexture = [self setupTexture:@"ground.png"];
    _woodTexture = [self setupTexture:@"wood.png"];
    _frameTexture = [self setupTexture:@"frame.png"];
    
    glActiveTexture(GL_TEXTURE1); //激活纹理单元
    glBindTexture(GL_TEXTURE_2D, _myTexture);
    glActiveTexture(GL_TEXTURE2);
    glBindTexture(GL_TEXTURE_2D, _groundTexture);
    glActiveTexture(GL_TEXTURE3);
    glBindTexture(GL_TEXTURE_2D, _woodTexture);
    glActiveTexture(GL_TEXTURE4);
    glBindTexture(GL_TEXTURE_2D, _frameTexture);

    
    [self setupMaterial:&metal withDfsTexture:1 spcTexture:1 Shininess:256.0];
    [self setupMaterial:&ground withDfsTexture:2 spcTexture:2 Shininess:8.0];
    [self setupMaterial:&wood withDfsTexture:3 spcTexture:4 Shininess:256.0];
//
//    NSLog(@"metal.dif = %u, _metaltex = %u", metal._difsLightingMap, _myTexture);
//    NSLog(@"grd.dif = %u, _grdtex = %u", ground._difsLightingMap, _groundTexture);
//    NSLog(@"wood.dif = %u, _woodtex = %u", wood._difsLightingMap, _woodTexture);


}

///////////////////////////////////////////


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
    ksMatrixLoadIdentity(&_modelMatrix);
    
    // Translate away from the viewer
    
    ksMatrixTranslate(&_modelMatrix, modelPos.x, modelPos.y, modelPos.z);
    
    // Rotate the triangle
    //
    ksMatrixRotate(&_modelMatrix, _angle, modleRotate.x, modleRotate.y, modleRotate.z);
    
    // Scale
    
    ksMatrixScale(&_modelMatrix, modelScale.x, modelScale.y, modelScale.z);
    
    // Load the model-view matrix(传送数据)
    glUniformMatrix4fv(_modelSlot, 1, GL_FALSE, (GLfloat*)&_modelMatrix.m[0][0]);
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

- (void) updateLight{
//    glUniform3f(_lightDrcSlot, _lightDirc.x, _lightDirc.y, _lightDirc.y);
//    update light para
    glUniform3f(_lightPositionSlot, light.position.x, light.position.y, light.position.z);
    glUniform3f(_lightDircSlot, light.direction.x, light.direction.y, light.direction.z);
    glUniform3f(_lightAmbientSlot, light.ambient.x, light.ambient.y, light.ambient.z);
    glUniform3f(_lightDiffuseSlot, light.diffuse.x, light.diffuse.y, light.diffuse.z);
    glUniform3f(_lightSpecularSlot, light.specular.x, light.specular.y, light.specular.z);
    glUniform1f(_lightConstantSlot, light.constant);
    glUniform1f(_lightLinearSlot, light.linear);
    glUniform1f(_lightQuadraticSlot, light.quadratic);
    glUniform1f(_lightCutOffSlot, light.cutOff);
    glUniform1f(_lightOuterCutOffSlot, light.outerCutOff);
}
- (void) updateMaterial{
    //update material para
    glUniform1i(_diffuseMapSlot, material._difsLightingMap);
    glUniform1i(_specularMapSlot, material._spclLightingMap);
    glUniform1f(_shininessSlot, material.shininess);
}

///////////////////////////////////////////////////////////

- (void)inintScene{
    //set viewport
    //使用glViewport设置UIView的一部分来进行渲染

    glViewport(0, 0, self.frame.size.width, self.frame.size.height);

    //static light spot
    //set light source position
    light.position.x = 0.0f;
    light.position.y = 0.0f;
    light.position.z = -25.0f;
    
    light.direction.x = 0.0f;
    light.direction.y = 0.0f;
    light.direction.z = -1.0f;
    
    //set Attenuation(衰减)
    light.constant = 1.0f;
    light.linear = 0.09f;
    light.quadratic = 0.032f;
    //light color
    ksVec3 lightColor = {1.0, 1.0, 1.0};
    ksVec3 abntIndex = {0.1, 0.1, 0.1};
    ksVec3 difsIndex = {0.9, 0.9, 0.9};
    lightColor.x = 1.0;
    lightColor.y = 1.0;
    lightColor.z = 1.0;
    fyVectorGLSLProduct(&light.ambient, &lightColor, &abntIndex);
    fyVectorGLSLProduct(&light.diffuse, &lightColor, &difsIndex);
    
    light.cutOff = cosf(12.5 / 180.0 * E_PI);
    light.outerCutOff = cosf(15.5 / 180.0 * E_PI);
    [self updateLight]; //static light
    
    [self updateProjection];// 更新投影矩阵

    
    
    
    
    //look at the same spot
    viewTgt.x = 0;
    viewTgt.y = 0;
    viewTgt.z = -30;
    [self updateView];
    [self updateProjection];
}

//////////////////////////////////////////////////////////////////////////////////////////

- (void)render {  //render func for shader
    glClearColor(0.05, 0.05, 0.05, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    //set view parameters
    static float viewRotateAngle = 0.57*E_PI;
    float viewRotateRad = 8;
    viewEye.x = viewRotateRad*cosf(viewRotateAngle);
    viewEye.y = 0.0;
    viewEye.z = viewRotateRad*sinf(viewRotateAngle)-30;
    viewRotateAngle += 0.01;
//////////    static eye pos
//    viewEye.x = 0.0f;
//    viewEye.y = 0.0f;
//    viewEye.z = -10.0f;
    //look at targets
    
    [self updateView];
//    light.position.x = viewEye.x;
//    light.position.y = viewEye.y;
//    light.position.z = viewEye.z;
    light.position = viewEye;
    light.direction.x = viewTgt.x - viewEye.x;
    light.direction.y = viewTgt.y - viewEye.y;
    light.direction.z = viewTgt.z - viewEye.z;
    glUniform3f(_lightPositionSlot, light.position.x, light.position.y, light.position.z);
    glUniform3f(_lightDircSlot, light.direction.x, light.direction.y, light.direction.z);
    
    //set light paras
    //rotate light direc
//    static float lightRotAngle = 0;
//    float lightRotRad = 100;
//    _lightDirc.x = lightRotRad * cosf(lightRotAngle);
//    _lightDirc.y = lightRotRad * sinf(lightRotAngle);
//    _lightDirc.z = -30;
//    lightRotAngle += 0.001;
//////static light dirct
//    _lightDirc.x = -0.2;
//    _lightDirc.y = -1.0;
//    _lightDirc.z = -0.3;
    
    //varing light color
//    static float colorAngle = 0;
//    lightColor.x = sinf(colorAngle * 2.0);
//    lightColor.y = sinf(colorAngle * 0.7);
//    lightColor.z = sinf(colorAngle * 1.3);
//    colorAngle += 0.01;

    

//    //ground
//    //using  texture
//    glUniform1i(_textureUniform, 0);
//    modelPos.x = 0;
//    modelPos.y = -3;
//    modelPos.z = -30;
//    modelScale.x = 15;
//    modelScale.y = 0;
//    modelScale.z = 15;
//    modleRotate.x = 0;
//    modleRotate.y = 0;
//    modleRotate.z = 0;
//    _angle = 0;
//    material = ground;
//
//    [self updateTransform];
//    [self updateMaterial];
//    glBindVertexArray(_groundObj);
//    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
//                   GL_UNSIGNED_BYTE, 0);
//    glBindVertexArray(0);//unbind
    
    /////////////////////////////
    // 一般当你打算绘制多个物体时，你首先要生成/配置所有的VAO（和必须的VBO及属性指针)，然后储存它们供后面使用。当我们打算绘制物体的时候就拿出相应的VAO，绑定它，绘制完物体后，再解绑VAO。
    glBindVertexArray(_objectA);
    //applying  texture
    //    glActiveTexture(GL_TEXTURE0);
    //    glBindTexture(GL_TEXTURE_2D, _myTexture);
    //    glUniform1i(_textureUniform, 0);
    material = wood;
    [self updateMaterial]; //all using same material
    for(unsigned int i = 0; i < 10; i++)
    {
        modelPos.x = cubePositions[i].x;
        modelPos.y = cubePositions[i].y;
        modelPos.z = cubePositions[i].z - 30;
        
        modleRotate.x = 1.0f;
        modleRotate.y = 0.3f;
        modleRotate.z = 0.5f;
        float angle = 20.0f * i;
        _angle = angle;
        modelScale.x = 0.7f;
        modelScale.y = 0.7f;
        modelScale.z = 0.7f;
        [self updateTransform];
        //调用glDrawElements。这最终会为传入的每个顶点调用顶点着色器，然后为将要显示的像素调用片段着色器。
        //参数：1绘制顶点的方式（GL_TRIANGLES, GL_LINES, GL_POINTS, etc.）, 2需要渲染的顶点个数，3索引数组中每个索引的数据类型，4（使用了已经传入GL_ELEMENT_ARRAY_BUFFER的索引数组）指向索引的指针。
        glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    }
    ///////////////////
    //draw the light source
    //    modelPos.x = -_lightDirc.x;
    //    modelPos.y = -_lightDirc.y;
    //    modelPos.z = -_lightDirc.z;
//    modelPos.x = light.position.x;
//    modelPos.y = light.position.y;
//    modelPos.z = light.position.z;
    modelPos = light.position;
    modelScale.x = 0.1;
    modelScale.y = 0.1;
    modelScale.z = 0.1;
    modleRotate.x = 0;
    modleRotate.y = 0;
    modleRotate.z = 0;
    _angle = 0;
    [self updateTransform];
    
//    material = metal;
//    [self updateMaterial];
    
    glBindVertexArray(_objectA);
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    glBindVertexArray(0);//unbind
    
    
    //cube A

    modelPos.x = 0.0;
    modelPos.y = 4.0;
    modelPos.z = -25.0;
    
    modleRotate.x = 1.0;
    modleRotate.y = 1.0;
    modleRotate.z = 1.0;
    static GLfloat angleA = 0;
//    angleA += 2;
    _angle = angleA;
    
    modelScale.x = 1.0f;
    modelScale.y = 1.0f;
    modelScale.z = 1.0f;
    [self updateTransform];
    
//    material = metal;
//    [self updateMaterial];

    glBindVertexArray(_objectA);// bind objA
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    glBindVertexArray(0);//unbind
    
    //cube 2
    //applying  texture
//    glActiveTexture(GL_TEXTURE0);
//    glBindTexture(GL_TEXTURE_2D, _woodTexture);
//    glUniform1i(_textureUniform, 0);
    modelPos.x = -5.0;
    modelPos.y = 1.5;
    modelPos.z = -30.0;
    
//    modleRotate.x = 1.0;
//    modleRotate.y = -1.0;
//    modleRotate.z = 1.0;
//    static GLfloat angleB = 0;
//    angleB += 0.3;
//    _angle = angleB;
//
    modelScale.x = 1.0f;
    modelScale.y = 1.0f;
    modelScale.z = 1.0f;
    
// material doesnt change here, dont have to update paras
//    material = metal;
//    [self updateMaterial];
    [self updateTransform];
    
    glBindVertexArray(_objectA);// bind objA
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    glBindVertexArray(0);//unbind
    
    //cube C
    //using  texture
//    glActiveTexture(GL_TEXTURE0);
//    glBindTexture(GL_TEXTURE_2D, _woodTexture);
//    glUniform1i(_textureUniform, 0);
    
    modelPos.x = 5.0;
    modelPos.y = 2.0;
    modelPos.z = -30.0;
    
    modleRotate.x = -1.0;
    modleRotate.y = 1.0;
    modleRotate.z = 1.0;
    static GLfloat angleC = 0;
//    angleC += 2;
    _angle = angleC;
    
    modelScale.x = 1;
    modelScale.y = 1;
    modelScale.z = 1;
    
//    material = metal;
    
    [self updateTransform];
//    [self updateMaterial];
    
    glBindVertexArray(_objectA);// bind objA
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    glBindVertexArray(0);//unbind
    
    //count fps
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    static UInt64 lasttime;
    UInt64 timval = recordTime - lasttime;
    lasttime = recordTime;
    int fps = (1.0/timval)*1000;
    NSLog(@"timval:%llums; FPS:%d", timval,fps);
    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}


@end


