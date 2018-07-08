
#version 300 es
in vec3 Position;
in vec4 SourceColor;
in vec2 TexCoordIn;
in vec3 normal;

out vec2 TexCoordOut;
out vec3 fragNormal;
out vec3 worldPos;

layout (std140) uniform Matrices  //use uniform block
{
    mat4 projection;
    mat4 lookView;
};

//uniform mat4 projection;
uniform mat4 model;
//uniform mat4 lookView;

void main()
{
    fragNormal = mat3(transpose(inverse(model))) * normal;
    gl_Position =   projection * lookView * model * vec4(Position, 1.0);
//    gl_PointSize = gl_Position.z; //modify point sprite size(bigger when further

    
    worldPos = vec3(model * vec4(Position, 1.0));
    TexCoordOut = TexCoordIn;
}
