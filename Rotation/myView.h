
#import <UIKit/UIKit.h>  //UIview etc.
#import <OpenGLES/ES3/gl.h>  //glXXX etc.

#include "ksMatrix.h"

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

    
    //VAOs are here
    GLuint _objectA;
    
    // every object could use these slots
    GLuint _positionSlot;
    GLuint _colorSlot;
    
    // uniform to set for every render action/object
    GLint _modelViewSlot;
    GLint _projectionSlot;
    
    GLuint _programHandle; //program be used to render, may have many programs.
    
    ksMatrix4 _modelViewMatrix;
    ksMatrix4 _projectionMatrix;
    
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


- (void)render;



@end


