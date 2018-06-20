
#import <UIKit/UIKit.h>  //UIview etc.
#import <OpenGLES/ES3/gl.h>  //glXXX etc.

#include "ksMatrix.h"
typedef struct {
    float Position[3];
    float Color[4];
    float Normal[3]; //法线
    float TexCoord[2]; // New
} Vertex;

typedef struct {  //光照材质
    GLuint _difsLightingMap;  //漫反射光照贴图纹理入口
    GLuint _spclLightingMap;  //镜面反射光照贴图纹理入口
    float shininess;
} Material;

typedef struct {
    ksVec3 position;
    ksVec3 direction;
    
    ksVec3 ambient;
    ksVec3 diffuse;
    ksVec3 specular;
    
    float constant;
    float linear;
    float quadratic;
    float cutOff;
    float outerCutOff;
} Light;

@interface GLView : UIView
{
    // val for a GLView
    CAEAGLLayer *_eaglLayer;
    EAGLContext *_context;
    GLuint _framebuffer;
    GLuint _colorrenderbuffer;
    GLuint _depthRenderBuffer;
    
    GLuint vertexBuffer;
    GLuint indexBuffer;
    GLuint groundVertexBuffer;
    GLuint groundIndexBuffer;
    
    GLuint _myTexture;
    GLuint _groundTexture;
    GLuint _woodTexture;
    GLuint _frameTexture;
    
    GLuint _texCoordSlot;
    GLuint _textureUniform;

    //VAOs are here
    GLuint _objectA;
    GLuint _groundObj;
    
    // every object could use these slots
    GLuint _positionSlot;
    GLuint _colorSlot;
    GLuint _normalSlot;
    
    // uniform to set for every render action/object
    GLint _modelSlot;
    GLint _lookViewSlot;
    GLint _projectionSlot;
    
    //light
//    GLint _lightDrcSlot;
    GLint _eyePosSlot;
//    GLint _ambientSlot;  //material
    GLint _diffuseMapSlot;  //lighting map
    GLint _specularMapSlot;
    GLint _shininessSlot;
    
    GLuint _lightPositionSlot;
    GLuint _lightDircSlot;
    GLuint _lightConstantSlot;
    GLuint _lightLinearSlot;
    GLuint _lightQuadraticSlot;
    GLint _lightAmbientSlot;  //light
    GLint _lightDiffuseSlot;
    GLint _lightSpecularSlot;
    GLuint _lightCutOffSlot;
    GLuint _lightOuterCutOffSlot;
    
    GLuint _programHandle; //program be used to render, may have many programs.
    
    ksMatrix4 _modelMatrix;
    ksMatrix4 _projectionMatrix;
    ksMatrix4 _lookViewMatrix;
//    ksVec3 _lightDirc;

    
    // vals for projection
    float _aspect;
    float _sightAngleY; //view y angle in degrees
    float _nearZ;
    float _farZ;
    
    // vals for the uniform transform matrices
//    float _posX;
//    float _posY;
//    float _posZ;
    ksVec3 modelPos;
    
//    float _rotateX;
//    float _rotateY;
//    float _rotateZ;
    float _angle;
    ksVec3 modleRotate;
    
//    float scaleX;
//    float scaleY;
//    float scaleZ;
    ksVec3 modelScale;
    
//    float eyeX;
//    float eyeY;
//    float eyeZ;
    ksVec3 viewEye;
    
//    float tgtX;
//    float tgtY;
//    float tgtZ;
    ksVec3 viewTgt;
    
    Material material;
    Material metal;
    Material wood;
    Material ground;
    
    Light light;
}

+ (Class)layerClass; //overwrite func layerClass

// func to set up val for whole view
- (void)setupLayer;
- (void)setupContext;

- (void)setupRenderBuffer;
- (void)setupDepthBuffer;
- (void)setupFrameBuffer;
- (void)destoryRenderAndFrameBuffer;

- (void)setupProjection;
- (void)setupTransform;//encapsule to func 'setup'
- (void)setupLookView;

// func to compile a program to '_programHandle', get and enable entry points of program:_positionSlot, _colorSlot, _modelSlot, _projectionSlot
- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType;
- (void)compileShaders;

//gen and set VAO
- (void)setupVAO;
- (void)setupVBOs;
- (void)setup;

//bind VAO and set program
//- (void)loadVertexArray: (GLuint) VAID withProgram: (GLuint) programHandle;

// set uniform for every render action(varies every time GPU renders)
- (void)updateTransform;
- (void)updateView;
- (void)updateProjection;
- (void)updateLight;
- (void)updateMaterial;

//update vals that don't change while rendering
- (void)inintScene;

- (void)render;



@end



