

#version 300 es
in vec3 Position;
in vec2 TexCoordIn;

uniform mat4 projection;
uniform mat4 model;
uniform mat4 lookView;

out vec2 TexCoordOut;

void main()
{
    gl_Position =   projection * lookView * model * vec4(Position, 1.0);
    TexCoordOut = TexCoordIn;
    
}
