
#version 300 es
in vec3 Position;
in vec4 SourceColor;
in vec2 TexCoordIn;
in vec3 normal;

out vec2 TexCoordOut;
out vec4 DestinationColor;
out vec3 fragNormal;
out vec3 worldPos;

uniform mat4 projection;
uniform mat4 modelView;
uniform mat4 lookView;

void main()
{
    fragNormal = mat3(transpose(inverse(modelView))) * normal;
    gl_Position =   projection * lookView * modelView * vec4(Position, 1.0);
    
    worldPos = vec3(modelView * vec4(Position, 1.0));
    DestinationColor = SourceColor;
    TexCoordOut = TexCoordIn;
}
