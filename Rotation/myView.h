
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

    GLuint programHandle;
    
    //vertex attributes for a object to render
    GLuint _positionSlot;
    GLuint _colorSlot;
    
    GLuint _hahaTexture;
    GLuint _texCoordSlot;
    GLuint _textureUniform;
    
    //uniforms
//    GLuint _varyColorSlot;
//    GLuint _radianAngle;
//    GLuint _transformMat;
    
    
    GLint _modelViewSlot;
    GLint _projectionSlot;
    
    ksMatrix4 _modelViewMatrix;
    ksMatrix4 _projectionMatrix;
    
    // vals for the transform matrices 
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

- (void)setupLayer;
- (void)setupContext;

- (void)setupRenderBuffer;
- (void)setupDepthBuffer;
- (void)setupFrameBuffer;

//gen and set VAO
//- (GLuint)setupRotationVAO;

- (void)destoryRenderAndFrameBuffer;

- (void)render;

- (void)updateTransform;
- (void)setupTransform;

- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType;
- (void)compileShaders;
- (void)setupVBOs;

- (void)setup;



@end


