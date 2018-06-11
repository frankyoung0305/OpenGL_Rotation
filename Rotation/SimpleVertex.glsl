
#version 300 es
in vec3 Position;
in vec4 SourceColor;
in vec2 TexCoordIn;

out vec2 TexCoordOut;
out vec4 DestinationColor;

uniform mat4 projection;
uniform mat4 modelView;
uniform mat4 lookView;

void main()
{
    gl_Position =   projection * lookView * modelView * vec4(Position, 1.0);
    DestinationColor = SourceColor;
    TexCoordOut = TexCoordIn;
}
