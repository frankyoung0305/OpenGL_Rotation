
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
} SpotLight;

//dir light
typedef struct {
    ksVec3 direction;
    
    ksVec3 ambient;
    ksVec3 diffuse;
    ksVec3 specular;
} DirLight;
//point light
typedef struct {
    ksVec3 position;
    
    float constant;
    float linear;
    float quadratic;
    
    ksVec3 ambient;
    ksVec3 diffuse;
    ksVec3 specular;
} PointLight;

@interface GLView : UIView
{
    // val for a GLView
    CAEAGLLayer *_eaglLayer;
    EAGLContext *_context;
    GLuint _framebuffer;
    GLuint _colorrenderbuffer;
    GLuint _depthStencilRenderBuffer;
    
    GLuint _renderedTexture; //texture target to draw on

    
    GLuint _textureFrameBuffer; //for render to texture
    
    GLuint vertexBuffer;
    GLuint indexBuffer;
    GLuint positionBuffer;
    
    GLuint groundVertexBuffer;
    GLuint groundIndexBuffer;
    GLuint grassVertexBuffer;
    GLuint grassIndexBuffer;
    
    GLuint _myTexture;
    GLuint _groundTexture;
    GLuint _woodTexture;
    GLuint _frameTexture;
    GLuint _grassTexture;
    GLuint _windowTexture;
    
    GLuint _skyBoxTexture;
    
    GLuint _texCoordSlot;

    //VAOs are here
    GLuint _objectA;
    GLuint _groundObj;
    GLuint _lampObj;
    GLuint _grassObj;
    GLuint _screenObj;
    
    //skybox vao
    GLuint skyboxVAO;
    GLuint skyboxVBO;
    GLuint skyboxIndexbuffer;

    
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
    //spotlight
    GLuint _spotLightPositionSlot;
    GLuint _spotLightDircSlot;
    GLuint _spotLightConstantSlot;
    GLuint _spotLightLinearSlot;
    GLuint _spotLightQuadraticSlot;
    GLuint _spotLightAmbientSlot;
    GLuint _spotLightDiffuseSlot;
    GLuint _spotLightSpecularSlot;
    GLuint _spotLightCutOffSlot;
    GLuint _spotLightOuterCutOffSlot;
    //directional light
    GLuint _dirLightDircSlot;
    GLuint _dirLightAmbntSlot;
    GLuint _dirLightDifsSlot;
    GLuint _dirLightSpclSlot;
    //point light
    GLuint _pointLightPosSlot0;
    GLuint _pointLightAmbntSlot0;
    GLuint _pointLightDifsSlot0;
    GLuint _pointLightSpclSlot0;
    GLuint _pointLightConstSlot0;
    GLuint _pointLightLinearSlot0;
    GLuint _pointLightQuadSlot0;
    
    GLuint _pointLightPosSlot1;
    GLuint _pointLightAmbntSlot1;
    GLuint _pointLightDifsSlot1;
    GLuint _pointLightSpclSlot1;
    GLuint _pointLightConstSlot1;
    GLuint _pointLightLinearSlot1;
    GLuint _pointLightQuadSlot1;
    
    GLuint _pointLightPosSlot2;
    GLuint _pointLightAmbntSlot2;
    GLuint _pointLightDifsSlot2;
    GLuint _pointLightSpclSlot2;
    GLuint _pointLightConstSlot2;
    GLuint _pointLightLinearSlot2;
    GLuint _pointLightQuadSlot2;
    
    GLuint _pointLightPosSlot3;
    GLuint _pointLightAmbntSlot3;
    GLuint _pointLightDifsSlot3;
    GLuint _pointLightSpclSlot3;
    GLuint _pointLightConstSlot3;
    GLuint _pointLightLinearSlot3;
    GLuint _pointLightQuadSlot3;
    ///////////slots for lamps
    GLuint _lampPositionSlot;
    GLuint _lampTexCoordSlot;

    GLint _lampModelSlot;
    GLint _lampLookViewSlot;
    GLint _lampProjectionSlot;
    GLint _lampTextureUniform;
    
    ///////////slots for screen shader program
    GLint _screenPosSlot;
    GLint _screenTexCoordSlot;
    GLint _screenTextureSlot;
    
    ///////////////
    GLuint _programHandle; //program be used to render, may have many programs.
    GLuint _lampProgram;
    GLuint _screenProgram; //for rendering from texture
    GLuint _skyBoxProgram;
    
    ksMatrix4 _modelMatrix;
    ksMatrix4 _projectionMatrix;
    ksMatrix4 _lookViewMatrix;
    
    ksMatrix4 _lampModelMatrix;  //for lamp
    ksMatrix4 _lampProjectionMatrix;
    ksMatrix4 _lampLookViewMatrix;
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
    ksVec3 modelRotate;
    
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
//lighting
    SpotLight spotLight;
    DirLight dirLight;
    PointLight pointLight;
    
//ubo
    GLuint uboMatrices;
}

+ (Class)layerClass; //overwrite func layerClass

// func to set up val for whole view
- (void)setupLayer;
- (void)setupContext;

- (void)setupRenderBuffer;
- (void)setupDepthStencilBuffer;
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

- (void)updateLampTransform;

//update vals that don't change while rendering
- (void)inintScene;

- (void)render;



@end



