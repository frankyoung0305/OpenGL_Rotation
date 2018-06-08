//
//  mathMatrix.c
//  Rotation
//
//  Created by Fan Yang on 2018/6/6.
//  Copyright © 2018年 byteD. All rights reserved.
//

#include "mathMatrix.h"
#include <math.h>

///////transformation funcs : rotate, scale, translate(move)


void rotateZ(Matrix4f* matrixTarget, float angle){
    matrixTarget->mat[0][0] = cosf(angle);
    matrixTarget->mat[0][1] = sinf(angle);
    matrixTarget->mat[0][2] = 0.0f;
    matrixTarget->mat[0][3] = 0.0f;
    matrixTarget->mat[1][0] = -sinf(angle);
    matrixTarget->mat[1][1] = cosf(angle);
    matrixTarget->mat[1][2] = 0.0f;
    matrixTarget->mat[1][3] = 0.0f;
    matrixTarget->mat[2][0] = 0.0f;
    matrixTarget->mat[2][1] = 0.0f;
    matrixTarget->mat[2][2] = 1.0f;
    matrixTarget->mat[2][3] = 0.0f;
    matrixTarget->mat[3][0] = 0.0f;
    matrixTarget->mat[3][1] = 0.0f;
    matrixTarget->mat[3][2] = 0.0f;
    matrixTarget->mat[3][3] = 1.0f;
}
void rotateY(Matrix4f* matrixTarget, float angle){
    matrixTarget->mat[0][0] = cosf(angle);
    matrixTarget->mat[0][1] = 0.0f;
    matrixTarget->mat[0][2] = -sinf(angle);
    matrixTarget->mat[0][3] = 0.0f;
    matrixTarget->mat[1][0] = 0.0f;
    matrixTarget->mat[1][1] = 1.0f;
    matrixTarget->mat[1][2] = 0.0f;
    matrixTarget->mat[1][3] = 0.0f;
    matrixTarget->mat[2][0] = sinf(angle);
    matrixTarget->mat[2][1] = 0.0f;
    matrixTarget->mat[2][2] = cosf(angle);
    matrixTarget->mat[2][3] = 0.0f;
    matrixTarget->mat[3][0] = 0.0f;
    matrixTarget->mat[3][1] = 0.0f;
    matrixTarget->mat[3][2] = 0.0f;
    matrixTarget->mat[3][3] = 1.0f;
}
void rotateX(Matrix4f* matrixTarget, float angle){
    matrixTarget->mat[0][0] = 1.0f;
    matrixTarget->mat[0][1] = 0.0f;
    matrixTarget->mat[0][2] = 0.0f;
    matrixTarget->mat[0][3] = 0.0f;
    matrixTarget->mat[1][0] = 0.0f;
    matrixTarget->mat[1][1] = cosf(angle);
    matrixTarget->mat[1][2] = sinf(angle);
    matrixTarget->mat[1][3] = 0.0f;
    matrixTarget->mat[2][0] = 0.0f;
    matrixTarget->mat[2][1] = -sinf(angle);
    matrixTarget->mat[2][2] = cosf(angle);
    matrixTarget->mat[2][3] = 0.0f;
    matrixTarget->mat[3][0] = 0.0f;
    matrixTarget->mat[3][1] = 0.0f;
    matrixTarget->mat[3][2] = 0.0f;
    matrixTarget->mat[3][3] = 1.0f;
}

void scale(Matrix4f* matrixTarget, float ration){
    matrixTarget->mat[0][0] = ration;
    matrixTarget->mat[0][1] = 0.0f;
    matrixTarget->mat[0][2] = 0.0f;
    matrixTarget->mat[0][3] = 0.0f;
    matrixTarget->mat[1][0] = 0.0f;
    matrixTarget->mat[1][1] = ration;
    matrixTarget->mat[1][2] = 0.0f;
    matrixTarget->mat[1][3] = 0.0f;
    matrixTarget->mat[2][0] = 0.0f;
    matrixTarget->mat[2][1] = 0.0f;
    matrixTarget->mat[2][2] = ration;
    matrixTarget->mat[2][3] = 0.0f;
    matrixTarget->mat[3][0] = 0.0f;
    matrixTarget->mat[3][1] = 0.0f;
    matrixTarget->mat[3][2] = 0.0f;
    matrixTarget->mat[3][3] = 1.0f;
}

void translate(Matrix4f* matrixTarget, float x, float y, float z){
    matrixTarget->mat[0][0] = 1.0f;
    matrixTarget->mat[0][1] = 0.0f;
    matrixTarget->mat[0][2] = 0.0f;
    matrixTarget->mat[0][3] = x;
    matrixTarget->mat[1][0] = 0.0f;
    matrixTarget->mat[1][1] = 1.0f;
    matrixTarget->mat[1][2] = 0.0f;
    matrixTarget->mat[1][3] = y;
    matrixTarget->mat[2][0] = 0.0f;
    matrixTarget->mat[2][1] = 0.0f;
    matrixTarget->mat[2][2] = 1.0f;
    matrixTarget->mat[2][3] = z;
    matrixTarget->mat[3][0] = 0.0f;
    matrixTarget->mat[3][1] = 0.0f;
    matrixTarget->mat[3][2] = 0.0f;
    matrixTarget->mat[3][3] = 1.0f;
}

void matrixMult(Matrix4f* res, const Matrix4f* matA, const Matrix4f* matB){
    res->mat[0][0] = matA->mat[0][0] * matB->mat[0][0] +
                    matA->mat[0][1] * matB->mat[1][0] +
                    matA->mat[0][2] * matB->mat[2][0] +
                    matA->mat[0][3] * matB->mat[3][0];
    res->mat[0][1] = matA->mat[0][0] * matB->mat[0][1] +
                    matA->mat[0][1] * matB->mat[1][1] +
                    matA->mat[0][2] * matB->mat[2][1] +
                    matA->mat[0][3] * matB->mat[3][1];
    res->mat[0][2] = matA->mat[0][0] * matB->mat[0][2] +
                    matA->mat[0][1] * matB->mat[1][2] +
                    matA->mat[0][2] * matB->mat[2][2] +
                    matA->mat[0][3] * matB->mat[3][2];
    res->mat[0][3] = matA->mat[0][0] * matB->mat[0][3] +
                    matA->mat[0][1] * matB->mat[1][3] +
                    matA->mat[0][2] * matB->mat[2][3] +
                    matA->mat[0][3] * matB->mat[3][3];
    
    res->mat[1][0] = matA->mat[1][0] * matB->mat[0][0] +
                    matA->mat[1][1] * matB->mat[1][0] +
                    matA->mat[1][2] * matB->mat[2][0] +
                    matA->mat[1][3] * matB->mat[3][0];
    res->mat[1][1] = matA->mat[1][0] * matB->mat[0][1] +
                    matA->mat[1][1] * matB->mat[1][1] +
                    matA->mat[1][2] * matB->mat[2][1] +
                    matA->mat[1][3] * matB->mat[3][1];
    res->mat[1][2] = matA->mat[1][0] * matB->mat[0][2] +
                    matA->mat[1][1] * matB->mat[1][2] +
                    matA->mat[1][2] * matB->mat[2][2] +
                    matA->mat[1][3] * matB->mat[3][2];
    res->mat[1][3] = matA->mat[1][0] * matB->mat[0][3] +
                    matA->mat[1][1] * matB->mat[1][3] +
                    matA->mat[1][2] * matB->mat[2][3] +
                    matA->mat[1][3] * matB->mat[3][3];
    
    res->mat[2][0] = matA->mat[2][0] * matB->mat[0][0] +
                    matA->mat[2][1] * matB->mat[1][0] +
                    matA->mat[2][2] * matB->mat[2][0] +
                    matA->mat[2][3] * matB->mat[3][0];
    res->mat[2][1] = matA->mat[2][0] * matB->mat[0][1] +
                    matA->mat[2][1] * matB->mat[1][1] +
                    matA->mat[2][2] * matB->mat[2][1] +
                    matA->mat[2][3] * matB->mat[3][1];
    res->mat[2][2] = matA->mat[2][0] * matB->mat[0][2] +
                    matA->mat[2][1] * matB->mat[1][2] +
                    matA->mat[2][2] * matB->mat[2][2] +
                    matA->mat[2][3] * matB->mat[3][2];
    res->mat[2][3] = matA->mat[2][0] * matB->mat[0][3] +
                    matA->mat[2][1] * matB->mat[1][3] +
                    matA->mat[2][2] * matB->mat[2][3] +
                    matA->mat[2][3] * matB->mat[3][3];
    
    res->mat[3][0] = matA->mat[3][0] * matB->mat[0][0] +
                    matA->mat[3][1] * matB->mat[1][0] +
                    matA->mat[3][2] * matB->mat[2][0] +
                    matA->mat[3][3] * matB->mat[3][0];
    res->mat[3][1] = matA->mat[3][0] * matB->mat[0][1] +
                    matA->mat[3][1] * matB->mat[1][1] +
                    matA->mat[3][2] * matB->mat[2][1] +
                    matA->mat[3][3] * matB->mat[3][1];
    res->mat[3][2] = matA->mat[3][0] * matB->mat[0][2] +
                    matA->mat[3][1] * matB->mat[1][2] +
                    matA->mat[3][2] * matB->mat[2][2] +
                    matA->mat[3][3] * matB->mat[3][2];
    res->mat[3][3] = matA->mat[3][0] * matB->mat[0][3] +
                    matA->mat[3][1] * matB->mat[1][3] +
                    matA->mat[3][2] * matB->mat[2][3] +
                    matA->mat[3][3] * matB->mat[3][3];
    
}







////////////////////
