#version 300 es
layout (location = 0) in vec3 aPos;

out vec3 TexCoords;

//uniform mat4 projection;
//uniform mat4 view;
layout (std140) uniform Matrices  //use uniform block
{
    mat4 projection;
    mat4 view;
};

void main()
{
    mat4 noTranslateView = view; //remove translation from camera
    noTranslateView[3].x = 0.0;
    noTranslateView[3].y = 0.0;
    noTranslateView[3].z = 0.0;

    TexCoords = vec3(aPos.x, aPos.y, aPos.z);
    vec4 pos = projection * noTranslateView * vec4(aPos, 1.0);
    gl_Position = pos.xyww;
}
