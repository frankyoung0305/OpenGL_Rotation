
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
    ksVec3 ambient;
    ksVec3 diffuse;
    ksVec3 specular;
    float shininess;
} Material;

typedef struct {    
    ksVec3 ambient;
    ksVec3 diffuse;
    ksVec3 specular;
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
    GLint _modelViewSlot;
    GLint _lookViewSlot;
    GLint _projectionSlot;
    
    //light
    GLint _lightPosSlot;
    GLint _eyePosSlot;
    GLint _ambientSlot;  //material
    GLint _diffuseSlot;
    GLint _specularSlot;
    GLint _shininessSlot;
    GLint _lightAmbientSlot;  //light
    GLint _lightDiffuseSlot;
    GLint _lightSpecularSlot;
    
    GLuint _programHandle; //program be used to render, may have many programs.
    
    ksMatrix4 _modelViewMatrix;
    ksMatrix4 _projectionMatrix;
    ksMatrix4 _lookViewMatrix;
    ksVec3 _lightPos;

    
    // vals for projection
    float _aspect;
    float _sightAngleY; //view y angle in degrees
    float _nearZ;
    float _farZ;
    
    // vals for the uniform transform matrices
    float _posX;
    float _posY;
    float _posZ;
    
    float _rotateX;
    float _rotateY;
    float _rotateZ;
    float _angle;
    
    float scaleX;
    float scaleY;
    float scaleZ;
    
    float eyeX;
    float eyeY;
    float eyeZ;
    
    float tgtX;
    float tgtY;
    float tgtZ;
    
    Material material;
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


- (void)setup;

// func to compile a program to '_programHandle', get and enable entry points of program:_positionSlot, _colorSlot, _modelViewSlot, _projectionSlot
- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType;
- (void)compileShaders;


//gen and set VAO
- (void)setupVAO;

- (void)setupVBOs;

//bind VAO and set program
//- (void)loadVertexArray: (GLuint) VAID withProgram: (GLuint) programHandle;

// set uniform for every render action(varies every time GPU renders)
- (void)updateTransform;
- (void)updateView;
- (void)updateProjection;
- (void)updateLight;

- (void)render;



@end


