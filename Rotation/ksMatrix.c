//
//  ksMatrix.c
//
//  Created by kesalin@gmail.com on 12-11-26.
//  Copyright (c) 2012. http://blog.csdn.net/kesalin/. All rights reserved.
//

#include "ksMatrix.h"
#include <stdlib.h>
#include <math.h>

void * memcpy(void *, const void *, size_t);
void * memset(void *, int, size_t);

unsigned int ksNextPot(unsigned int n)
{
	n--;
	n |= n >> 1; n |= n >> 2;
	n |= n >> 4; n |= n >> 8;
	n |= n >> 16;
	n++;
	return n;
}

//
// Matrix math utility
//

void ksMatrixScale(ksMatrix4 * result, float sx, float sy, float sz)
{
	result->m[0][0] *= sx;
	result->m[1][0] *= sx;
	result->m[2][0] *= sx;
	result->m[3][0] *= sx;

	result->m[0][1] *= sy;
	result->m[1][1] *= sy;
	result->m[2][1] *= sy;
	result->m[3][1] *= sy;

	result->m[0][2] *= sz;
	result->m[1][2] *= sz;
	result->m[2][2] *= sz;
	result->m[3][2] *= sz;
}

void ksMatrixTranslate(ksMatrix4 * result, float tx, float ty, float tz)  //question
{
//    result->m[3][0] += (result->m[0][0] * tx + result->m[1][0] * ty + result->m[2][0] * tz);
//    result->m[3][1] += (result->m[0][1] * tx + result->m[1][1] * ty + result->m[2][1] * tz);
//    result->m[3][2] += (result->m[0][2] * tx + result->m[1][2] * ty + result->m[2][2] * tz);
//    result->m[3][3] += (result->m[0][3] * tx + result->m[1][3] * ty + result->m[2][3] * tz);
    result->m[3][0] += result->m[3][3] * tx;
    result->m[3][1] += result->m[3][3] * ty;
    result->m[3][2] += result->m[3][3] * tz;

}

void ksMatrixRotate(ksMatrix4 * result, float angle, float x, float y, float z)
{
	float sinAngle, cosAngle;
	float mag = sqrtf(x * x + y * y + z * z);

	sinAngle = sinf ( angle * M_PI / 180.0f );
	cosAngle = cosf ( angle * M_PI / 180.0f );
	if ( mag > 0.0f )
	{
		float xx, yy, zz, xy, yz, zx, xs, ys, zs;
		float oneMinusCos;
		ksMatrix4 rotMat;

		x /= mag;
		y /= mag;
		z /= mag;

		xx = x * x;
		yy = y * y;
		zz = z * z;
		xy = x * y;
		yz = y * z;
		zx = z * x;
		xs = x * sinAngle;
		ys = y * sinAngle;
		zs = z * sinAngle;
		oneMinusCos = 1.0f - cosAngle;

		rotMat.m[0][0] = (oneMinusCos * xx) + cosAngle;
		rotMat.m[1][0] = (oneMinusCos * xy) - zs;
		rotMat.m[2][0] = (oneMinusCos * zx) + ys;
		rotMat.m[3][0] = 0.0F;

		rotMat.m[0][1] = (oneMinusCos * xy) + zs;
		rotMat.m[1][1] = (oneMinusCos * yy) + cosAngle;
		rotMat.m[2][1] = (oneMinusCos * yz) - xs;
		rotMat.m[3][1] = 0.0F;

		rotMat.m[0][2] = (oneMinusCos * zx) - ys;
		rotMat.m[1][2] = (oneMinusCos * yz) + xs;
		rotMat.m[2][2] = (oneMinusCos * zz) + cosAngle;
		rotMat.m[3][2] = 0.0F;

		rotMat.m[0][3] = 0.0F;
		rotMat.m[1][3] = 0.0F;
		rotMat.m[2][3] = 0.0F;
		rotMat.m[3][3] = 1.0F;

		ksMatrixMultiply( result, &rotMat, result );
	}
}

// result[x][y] = a[x][0]*b[0][y]+a[x][1]*b[1][y]+a[x][2]*b[2][y]+a[x][3]*b[3][y];
void ksMatrixMultiply(ksMatrix4 * result, const ksMatrix4 *a, const ksMatrix4 *b)
{
	ksMatrix4 tmp;
	int i;

	for (i = 0; i < 4; i++)
	{
		tmp.m[i][0] = (a->m[i][0] * b->m[0][0]) +
			(a->m[i][1] * b->m[1][0]) +
			(a->m[i][2] * b->m[2][0]) +
			(a->m[i][3] * b->m[3][0]) ;

		tmp.m[i][1] = (a->m[i][0] * b->m[0][1]) + 
			(a->m[i][1] * b->m[1][1]) +
			(a->m[i][2] * b->m[2][1]) +
			(a->m[i][3] * b->m[3][1]) ;

		tmp.m[i][2] = (a->m[i][0] * b->m[0][2]) + 
			(a->m[i][1] * b->m[1][2]) +
			(a->m[i][2] * b->m[2][2]) +
			(a->m[i][3] * b->m[3][2]) ;

		tmp.m[i][3] = (a->m[i][0] * b->m[0][3]) + 
			(a->m[i][1] * b->m[1][3]) +
			(a->m[i][2] * b->m[2][3]) +
			(a->m[i][3] * b->m[3][3]) ;
	}

	memcpy(result, &tmp, sizeof(ksMatrix4));
}

void ksMatrixDotVector(ksVec4 * out, const ksMatrix4 * m, const ksVec4 * v)
{
	out->x = m->m[0][0] * v->x + m->m[0][1] * v->y + m->m[0][2] * v->z + m->m[0][3] * v->w;
	out->y = m->m[1][0] * v->x + m->m[1][1] * v->y + m->m[1][2] * v->z + m->m[1][3] * v->w;
	out->z = m->m[2][0] * v->x + m->m[2][1] * v->y + m->m[2][2] * v->z + m->m[2][3] * v->w;
	out->w = m->m[3][0] * v->x + m->m[3][1] * v->y + m->m[3][2] * v->z + m->m[3][3] * v->w;
}

void ksMatrixCopy(ksMatrix4 * target, const ksMatrix4 * src)
{
	memcpy(target, src, sizeof(ksMatrix4));
}

int ksMatrixInvert(ksMatrix4 * out, const ksMatrix4 * in)
{
	float * m = (float *)(&in->m[0][0]);
	float * om = (float *)(&out->m[0][0]);
	double inv[16], det;
	int i;

	inv[0] = m[5]  * m[10] * m[15] - 
		m[5]  * m[11] * m[14] - 
		m[9]  * m[6]  * m[15] + 
		m[9]  * m[7]  * m[14] +
		m[13] * m[6]  * m[11] - 
		m[13] * m[7]  * m[10];

	inv[4] = -m[4]  * m[10] * m[15] + 
		m[4]  * m[11] * m[14] + 
		m[8]  * m[6]  * m[15] - 
		m[8]  * m[7]  * m[14] - 
		m[12] * m[6]  * m[11] + 
		m[12] * m[7]  * m[10];

	inv[8] = m[4]  * m[9] * m[15] - 
		m[4]  * m[11] * m[13] - 
		m[8]  * m[5] * m[15] + 
		m[8]  * m[7] * m[13] + 
		m[12] * m[5] * m[11] - 
		m[12] * m[7] * m[9];

	inv[12] = -m[4]  * m[9] * m[14] + 
		m[4]  * m[10] * m[13] +
		m[8]  * m[5] * m[14] - 
		m[8]  * m[6] * m[13] - 
		m[12] * m[5] * m[10] + 
		m[12] * m[6] * m[9];

	inv[1] = -m[1]  * m[10] * m[15] + 
		m[1]  * m[11] * m[14] + 
		m[9]  * m[2] * m[15] - 
		m[9]  * m[3] * m[14] - 
		m[13] * m[2] * m[11] + 
		m[13] * m[3] * m[10];

	inv[5] = m[0]  * m[10] * m[15] - 
		m[0]  * m[11] * m[14] - 
		m[8]  * m[2] * m[15] + 
		m[8]  * m[3] * m[14] + 
		m[12] * m[2] * m[11] - 
		m[12] * m[3] * m[10];

	inv[9] = -m[0]  * m[9] * m[15] + 
		m[0]  * m[11] * m[13] + 
		m[8]  * m[1] * m[15] - 
		m[8]  * m[3] * m[13] - 
		m[12] * m[1] * m[11] + 
		m[12] * m[3] * m[9];

	inv[13] = m[0]  * m[9] * m[14] - 
		m[0]  * m[10] * m[13] - 
		m[8]  * m[1] * m[14] + 
		m[8]  * m[2] * m[13] + 
		m[12] * m[1] * m[10] - 
		m[12] * m[2] * m[9];

	inv[2] = m[1]  * m[6] * m[15] - 
		m[1]  * m[7] * m[14] - 
		m[5]  * m[2] * m[15] + 
		m[5]  * m[3] * m[14] + 
		m[13] * m[2] * m[7] - 
		m[13] * m[3] * m[6];

	inv[6] = -m[0]  * m[6] * m[15] + 
		m[0]  * m[7] * m[14] + 
		m[4]  * m[2] * m[15] - 
		m[4]  * m[3] * m[14] - 
		m[12] * m[2] * m[7] + 
		m[12] * m[3] * m[6];

	inv[10] = m[0]  * m[5] * m[15] - 
		m[0]  * m[7] * m[13] - 
		m[4]  * m[1] * m[15] + 
		m[4]  * m[3] * m[13] + 
		m[12] * m[1] * m[7] - 
		m[12] * m[3] * m[5];

	inv[14] = -m[0]  * m[5] * m[14] + 
		m[0]  * m[6] * m[13] + 
		m[4]  * m[1] * m[14] - 
		m[4]  * m[2] * m[13] - 
		m[12] * m[1] * m[6] + 
		m[12] * m[2] * m[5];

	inv[3] = -m[1] * m[6] * m[11] + 
		m[1] * m[7] * m[10] + 
		m[5] * m[2] * m[11] - 
		m[5] * m[3] * m[10] - 
		m[9] * m[2] * m[7] + 
		m[9] * m[3] * m[6];

	inv[7] = m[0] * m[6] * m[11] - 
		m[0] * m[7] * m[10] - 
		m[4] * m[2] * m[11] + 
		m[4] * m[3] * m[10] + 
		m[8] * m[2] * m[7] - 
		m[8] * m[3] * m[6];

	inv[11] = -m[0] * m[5] * m[11] + 
		m[0] * m[7] * m[9] + 
		m[4] * m[1] * m[11] - 
		m[4] * m[3] * m[9] - 
		m[8] * m[1] * m[7] + 
		m[8] * m[3] * m[5];

	inv[15] = m[0] * m[5] * m[10] - 
		m[0] * m[6] * m[9] - 
		m[4] * m[1] * m[10] + 
		m[4] * m[2] * m[9] + 
		m[8] * m[1] * m[6] - 
		m[8] * m[2] * m[5];

	det = m[0] * inv[0] + m[1] * inv[4] + m[2] * inv[8] + m[3] * inv[12];

	if (det == 0)
		return 0;

	det = 1.0 / det;
	for (i = 0; i < 16; i++)
		*om++ = (float)(inv[i] * det);

	return 1;
}

void ksMatrixTranspose(ksMatrix4 * result, const ksMatrix4 * src)
{
	ksMatrix4 tmp;
	tmp.m[0][0] = src->m[0][0]; 
	tmp.m[0][1] = src->m[1][0];
	tmp.m[0][2] = src->m[2][0];
	tmp.m[0][3] = src->m[3][0];

	tmp.m[1][0] = src->m[0][1]; 
	tmp.m[1][1] = src->m[1][1];
	tmp.m[1][2] = src->m[2][1];
	tmp.m[1][3] = src->m[3][1];

	tmp.m[2][0] = src->m[0][2]; 
	tmp.m[2][1] = src->m[1][2];
	tmp.m[2][2] = src->m[2][2];
	tmp.m[2][3] = src->m[3][2];

	tmp.m[3][0] = src->m[0][3]; 
	tmp.m[3][1] = src->m[1][3];
	tmp.m[3][2] = src->m[2][3];
	tmp.m[3][3] = src->m[3][3];

	memcpy(result, &tmp, sizeof(ksMatrix4));
}

void ksMatrix4ToMatrix3(ksMatrix3 * result, const ksMatrix4 * src)
{
	result->m[0][0] = src->m[0][0];
	result->m[0][1] = src->m[0][1];
	result->m[0][2] = src->m[0][2];
	result->m[1][0] = src->m[1][0];
	result->m[1][1] = src->m[1][1];
	result->m[1][2] = src->m[1][2];
	result->m[2][0] = src->m[2][0];
	result->m[2][1] = src->m[2][1];
	result->m[2][2] = src->m[2][2];
}

void ksMatrixLoadIdentity(ksMatrix4 * result)
{
	memset(result, 0x0, sizeof(ksMatrix4));

	result->m[0][0] = 1.0f;
	result->m[1][1] = 1.0f;
	result->m[2][2] = 1.0f;
	result->m[3][3] = 1.0f;
}

void ksFrustum(ksMatrix4 * result, float left, float right, float bottom, float top, float nearZ, float farZ)
{
	float       deltaX = right - left;
	float       deltaY = top - bottom;
	float       deltaZ = farZ - nearZ;
	ksMatrix4    frust;

	if ( (nearZ <= 0.0f) || (farZ <= 0.0f) ||
		(deltaX <= 0.0f) || (deltaY <= 0.0f) || (deltaZ <= 0.0f) )
		return;

	frust.m[0][0] = 2.0f * nearZ / deltaX;
	frust.m[0][1] = frust.m[0][2] = frust.m[0][3] = 0.0f;

	frust.m[1][1] = 2.0f * nearZ / deltaY;
	frust.m[1][0] = frust.m[1][2] = frust.m[1][3] = 0.0f;

	frust.m[2][0] = (right + left) / deltaX;
	frust.m[2][1] = (top + bottom) / deltaY;
	frust.m[2][2] = -(nearZ + farZ) / deltaZ;
	frust.m[2][3] = -1.0f;

	frust.m[3][2] = -2.0f * nearZ * farZ / deltaZ;
	frust.m[3][0] = frust.m[3][1] = frust.m[3][3] = 0.0f;

	ksMatrixMultiply(result, &frust, result);
}

void ksPerspective(ksMatrix4 * result, float fovy, float aspect, float nearZ, float farZ)
{
	float frustumW, frustumH;

	frustumH = tanf( fovy / 360.0f * M_PI ) * nearZ;
	frustumW = frustumH * aspect;

    ksFrustum(result, -frustumW, frustumW, -frustumH, frustumH, nearZ, farZ);
}

void ksOrtho(ksMatrix4 * result, float left, float right, float bottom, float top, float nearZ, float farZ)
{
	float       deltaX = right - left;
	float       deltaY = top - bottom;
	float       deltaZ = farZ - nearZ;
	ksMatrix4    ortho;

	if ((deltaX == 0.0f) || (deltaY == 0.0f) || (deltaZ == 0.0f))
		return;

	ksMatrixLoadIdentity(&ortho);
	ortho.m[0][0] = 2.0f / deltaX;
	ortho.m[3][0] = -(right + left) / deltaX;
	ortho.m[1][1] = 2.0f / deltaY;
	ortho.m[3][1] = -(top + bottom) / deltaY;
	ortho.m[2][2] = -2.0f / deltaZ;
	ortho.m[3][2] = -(nearZ + farZ) / deltaZ;

	ksMatrixMultiply(result, &ortho, result);
}

void ksLookAt(ksMatrix4 * result, const ksVec3 * eye, const ksVec3 * target, const ksVec3 * up)
{
//    ksVec3 side, up2, forward ;
//    //ksVec4 eyePrime;
//    ksMatrix4 transMat;
//
//    ksVectorSubtract(&forward, eye, target); //point to eye
//    ksVectorNormalize(&forward);
//
//    ksCrossProduct(&side, up, &forward);  //right vec
//    ksVectorNormalize(&side);
//
//    ksCrossProduct(&up2, &forward, &side);
//    ksVectorNormalize(&up2);
//
//    ksMatrixLoadIdentity(result);
//    result->m[0][0] = side.x;
//    result->m[1][0] = side.y;
//    result->m[2][0] = side.z;
//    result->m[0][1] = up2.x;
//    result->m[1][1] = up2.y;
//    result->m[2][1] = up2.z;
//    result->m[0][2] = forward.x;
//    result->m[1][2] = forward.y;
//    result->m[2][2] = forward.z;
//
//    ksMatrixLoadIdentity(&transMat);
//    ksMatrixTranslate(&transMat, -eye->x, -eye->y, -eye->z);
//
//    ksMatrixMultiply(result, result, &transMat);
//
////    eyePrime.x = -eye->x;
////    eyePrime.y = -eye->y;
////    eyePrime.z = -eye->z;
////    eyePrime.w = 1;
////
////    ksMatrixMultiplyVector(&eyePrime, result, &eyePrime);
////    ksMatrixTranspose(result, result);
////
////    result->m[3][0] = eyePrime.x;
////    result->m[3][1] = eyePrime.y;
////    result->m[3][2] = eyePrime.z;
////    result->m[3][3] = eyePrime.w;
    
    
    
    
//    ///////////////////////////////////////
//    ESMatrix *result,
//    float posX,    float posY,    float posZ,
//    float lookAtX, float lookAtY, float lookAtZ,
//    float upX,     float upY,     float upZ
    
    
    float axisX[3], axisY[3], axisZ[3];
    float length;

    // axisZ 指向camera的z方向（摄像机方向的反向
    axisZ[0] = eye->x - target->x;
    axisZ[1] = eye->y - target->y;
    axisZ[2] = eye->z - target->z;

    // normalize axisZ
    length = sqrtf ( axisZ[0] * axisZ[0] + axisZ[1] * axisZ[1] + axisZ[2] * axisZ[2] );

    if ( length != 0.0f )
    {
        axisZ[0] /= length;
        axisZ[1] /= length;
        axisZ[2] /= length;
    }

    // axisX = up X axisZ
    axisX[0] = up->y * axisZ[2] - up->z * axisZ[1];
    axisX[1] = up->z * axisZ[0] - up->x * axisZ[2];
    axisX[2] = up->x * axisZ[1] - up->y * axisZ[0];

    // normalize axisX
    length = sqrtf ( axisX[0] * axisX[0] + axisX[1] * axisX[1] + axisX[2] * axisX[2] );

    if ( length != 0.0f )
    {
        axisX[0] /= length;
        axisX[1] /= length;
        axisX[2] /= length;
    }

    // axisY = axisZ x axisX
    axisY[0] = axisZ[1] * axisX[2] - axisZ[2] * axisX[1];
    axisY[1] = axisZ[2] * axisX[0] - axisZ[0] * axisX[2];
    axisY[2] = axisZ[0] * axisX[1] - axisZ[1] * axisX[0];

    // normalize axisY
    length = sqrtf ( axisY[0] * axisY[0] + axisY[1] * axisY[1] + axisY[2] * axisY[2] );

    if ( length != 0.0f )
    {
        axisY[0] /= length;
        axisY[1] /= length;
        axisY[2] /= length;
    }

    ksMatrixLoadIdentity(result);

    result->m[0][0] =  axisX[0];
    result->m[0][1] =  axisY[0];
    result->m[0][2] =  axisZ[0];

    result->m[1][0] =  axisX[1];
    result->m[1][1] =  axisY[1];
    result->m[1][2] =  axisZ[1];

    result->m[2][0] =  axisX[2];
    result->m[2][1] =  axisY[2];
    result->m[2][2] =  axisZ[2];

    // translate (-posX, -posY, -posZ)
    result->m[3][0] = -axisX[0] * eye->x - axisX[1] * eye->y - axisX[2] * eye->z;
    result->m[3][1] = -axisY[0] * eye->x - axisY[1] * eye->y - axisY[2] * eye->z;
    result->m[3][2] = -axisZ[0] * eye->x - axisZ[1] * eye->y - axisZ[2] * eye->z;
    result->m[3][3] = 1.0f;
}
