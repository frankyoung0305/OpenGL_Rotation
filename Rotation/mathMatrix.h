//
//  mathMatrix.h
//  Rotation
//
//  Created by Fan Yang on 2018/6/6.
//  Copyright © 2018年 byteD. All rights reserved.
//

#ifndef mathMatrix_h
#define mathMatrix_h

#include <stdio.h>
typedef struct{
    float mat[4][4];
} Matrix4f;


///////transformation funcs : rotate, scale, translate(move)
void rotateZ(Matrix4f* matrixTarget, float angle);
void rotateY(Matrix4f* matrixTarget, float angle);
void rotateX(Matrix4f* matrixTarget, float angle);

void scale(Matrix4f* matrixTarget, float ration);

void translate(Matrix4f* matrixTarget, float x, float y, float z);

void matrixMult(Matrix4f* matA, Matrix4f* matB);



#endif /* mathMatrix_h */
