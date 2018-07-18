
#version 300 es
in vec3 Position;
in vec4 SourceColor;
in vec2 TexCoordIn;
in vec3 normal;
//positions
in vec3 CubePosition;

out vec2 TexCoordOut;
out vec3 fragNormal;
out vec3 worldPos;
out vec4 FragPosLightSpace;//

layout (std140) uniform Matrices  //use uniform block
{
    mat4 projection;
    mat4 lookView;
};

//uniform mat4 projection;
uniform mat4 model;
//uniform mat4 lookView;
uniform mat4 lightSpaceMatrix;
//vec3 cubePositions[10] = vec3[](
//                                vec3( 0.1f,  0.0f, -0.1f ),
//                                vec3( 0.1f,  1.0f, -0.1f),
//                                vec3( 0.1f,  2.0f, -0.1f ),
//                                vec3( 0.1f,  3.0f, -0.1f),
//                                vec3( 0.1f,  4.0f, -0.1f ),
//                                vec3( 0.1f,  5.0f, -0.1f ),
//                                vec3( 0.1f,  6.0f, -0.1f ),
//                                vec3( 0.1f,  7.0f, -0.1f ),
//                                vec3( 0.1f,  8.0f, -0.1f ),
//                                vec3( 0.1f,  9.0f, -0.1f )
//                                );

void main()
{
    fragNormal = mat3(transpose(inverse(model))) * normal;
//    gl_Position =   projection * lookView * model * vec4(Position, 1.0) + vec4(CubePosition, 1.0f);
    gl_Position =   projection * lookView * model * vec4(Position, 1.0);

//    gl_PointSize = gl_Position.z; //modify point sprite size(bigger when further

    
    worldPos = vec3(model * vec4(Position, 1.0));
    TexCoordOut = TexCoordIn;
    FragPosLightSpace = lightSpaceMatrix * vec4(worldPos, 1.0);
}
